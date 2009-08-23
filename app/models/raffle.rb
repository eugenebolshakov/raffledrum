class Raffle < ActiveRecord::Base
  # Attributes
  attr_accessible :prize, :start_time, :end_time, :hashtag

  # Associations
  belongs_to :user
  has_many :participants
  belongs_to :winner, :class_name => 'Participant'

  # Validations
  validates_presence_of :prize, :start_time, :end_time, :hashtag
  validates_format_of :hashtag, :with => /^[A-Z\d]{1,16}$/i, 
    :message => 'must be 16 chars max. Letters or digits only'

  # Hooks
  before_validation_on_create :change_end_time_to_end_of_day

  # Named Scopes
  named_scope :active, lambda {{
    :conditions => ['start_time <= :now AND end_time >= :now', {:now => Time.now.utc}],
    :order      => 'end_time ASC'
  }}
  named_scope :inactive, lambda {{
    :conditions => ['start_time > :now OR end_time < :now', {:now => Time.now.utc}],
    :order      => 'end_time DESC'
  }}

  # Instance Methods
  def hashtag=(value)
    value.gsub!(/^#/, '') if value.is_a?(String)
    write_attribute(:hashtag, value)
  end

  def active?
    start_time <= Time.now && end_time >= Time.now
  end

  def ended?
    end_time < Time.now
  end

  def future?
    start_time > Time.now
  end

  def pick_winner!
    if participants.loosers.count.zero?
      participants.update_all('winner = 0')
    end
    winner = participants.loosers.find(:first, :order => 'rand()')
    if winner
      winner.update_attribute(:winner, true)
      update_attribute(:winner, winner)
    end
  end

  private

    def change_end_time_to_end_of_day
      if end_time
        self.end_time = end_time.end_of_day
      end
    end
end

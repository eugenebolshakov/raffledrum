class Raffle < ActiveRecord::Base
  # Attributes
  attr_accessible :prize, :start_time, :end_time, :hashtag

  # Associations
  belongs_to :user
  has_many :participants

  # Validations
  validates_presence_of :prize, :start_time, :end_time, :hashtag
  validates_format_of :hashtag, :with => /^[A-Z\d]{1,16}$/i, 
    :message => 'must be 16 chars max. Letters or digits only'

  # Named Scopes
  default_scope :order => 'end_time DESC'

  named_scope :for_update, 
    :conditions => ['start_time <= ? AND end_time >= ?', Time.now.utc, (Time.now - 30.minutes).utc]

  # Instance Methods
  def hashtag=(value)
    value.gsub!(/^#/, '') if value.is_a?(String)
    write_attribute(:hashtag, value)
  end
end

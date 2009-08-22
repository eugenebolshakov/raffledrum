class Raffle < ActiveRecord::Base
  # Attributes
  attr_accessible :prize, :start_time, :end_time, :hashtag

  # Associations
  belongs_to :user
  has_many :participants

  # Validations
  validates_presence_of :prize, :start_time, :end_time, :hashtag

  # Named Scopes
  named_scope :for_update, 
    :conditions => ['start_time <= ? AND end_time >= ?', Time.now.utc, (Time.now - 30.minutes).utc]
end

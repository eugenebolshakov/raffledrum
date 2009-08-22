class Raffle < ActiveRecord::Base
  # Attributes
  attr_accessible :prize, :start_time, :end_time, :hashtag

  # Associations
  belongs_to :user

  # Validations
  validates_presence_of :prize, :start_time, :end_time, :hashtag

end

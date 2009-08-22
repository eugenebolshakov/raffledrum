class Participant < ActiveRecord::Base
  # Associations
  belongs_to :raffle

  # Validations
  validates_uniqueness_of :twitter_user_id, :scope => :raffle_id
end

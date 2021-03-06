class Participant < ActiveRecord::Base
  # Attributes
  xss_terminate :except => [:twitter_user_id, :tweet_id]

  # Associations
  belongs_to :raffle

  # Validations
  validates_uniqueness_of :twitter_user_id, :scope => :raffle_id

  # Named Scopes
  default_scope :order => 'posted_at DESC'
  named_scope :loosers, :conditions => {:winner => false}
end

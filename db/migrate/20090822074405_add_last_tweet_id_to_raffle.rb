class AddLastTweetIdToRaffle < ActiveRecord::Migration
  def self.up
    add_column :raffles, :last_tweet_id, :string
  end

  def self.down
    remove_column :raffles, :last_tweet_id
  end
end

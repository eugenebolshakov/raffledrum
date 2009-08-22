class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.belongs_to :raffle
      t.string :twitter_user_id, :twitter_login, :twitter_image, :tweet, :tweet_id
      t.datetime :posted_at
      t.timestamps
    end
    add_index :participants, :raffle_id
  end

  def self.down
    drop_table :participants
  end
end

class CreateRaffles < ActiveRecord::Migration
  def self.up
    create_table :raffles do |t|
      t.belongs_to :user
      t.string :prize
      t.datetime :start_time
      t.datetime :end_time
      t.string :hashtag
      t.timestamps
    end
    add_index :raffles, :user_id
  end

  def self.down
    drop_table :raffles
  end
end

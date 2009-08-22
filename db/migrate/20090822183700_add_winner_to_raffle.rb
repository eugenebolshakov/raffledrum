class AddWinnerToRaffle < ActiveRecord::Migration
  def self.up
    add_column :raffles, :winner_id, :integer
  end

  def self.down
    remove_column :raffles, :winner_id
  end
end

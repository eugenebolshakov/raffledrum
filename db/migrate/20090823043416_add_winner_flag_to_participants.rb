class AddWinnerFlagToParticipants < ActiveRecord::Migration
  def self.up
    add_column :participants, :winner, :boolean
  end

  def self.down
    remove_column :participants, :winner
  end
end

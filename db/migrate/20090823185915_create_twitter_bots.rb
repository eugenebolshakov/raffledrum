class CreateTwitterBots < ActiveRecord::Migration
  def self.up
    create_table :twitter_bots do |t|
      t.string :login, :crypted_password, :salt
    end
    [
      {:login => 'raffledrum', :password => '911iddqd'},
      {:login => 'raffledrum_test', :password => '911iddqd'},
      {:login => 'raffledrum_tes2', :password => '911iddqd'}
    ].each do |attr|
      TwitterBot.create(attr)
    end
  end

  def self.down
    drop_table :twitter_bots
  end
end

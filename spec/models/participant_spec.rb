require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Participant do
  before(:each) do
    @it = Participant.new
  end

  specify { @it.should belong_to(:raffle) }

  it 'should validate uniqueness of user scoped by raffle' do
    raffle = Factory :raffle
    Factory :participant, :raffle => raffle
    @it.should validate_uniqueness_of(:twitter_user_id).scoped_to(:raffle_id)
  end
end

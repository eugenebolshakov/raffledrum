require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RafflePickWinnerJob do
  before(:each) do
    @raffle = Factory :raffle
    3.times { Factory :participant, :raffle => @raffle }
    @it = RafflePickWinnerJob.new(@raffle.id)
  end

  it 'should pick the winner' do
    @raffle.winner.should be_nil
    @it.perform
    @raffle.reload.winner.should_not be_nil
  end
end

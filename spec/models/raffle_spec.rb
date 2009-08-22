require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Raffle do
  before(:each) do
    @it = Raffle.new
  end

  %w(prize start_time end_time hashtag).each do |attr|
    specify { @it.should allow_mass_assignment_of(attr) }
  end

  specify { @it.should belong_to(:user) }
  specify { @it.should have_many(:participants) }

  %w(prize start_time end_time hashtag).each do |attr|
    specify { @it.should validate_presence_of(attr) }
  end

  describe 'when returning raffles for udpate' do
    it 'should not return raffles that have not started yet' do
      Factory :raffle, :start_time => 1.hour.from_now
      Raffle.for_update.should be_empty
    end

    it 'should return raffles that are running now' do
      r = Factory :raffle, :start_time => 1.minute.ago
      Raffle.for_update.should == [r]
    end

    it 'should return raffles that ended 30 minutes ago max' do
      r = Factory :raffle, :start_time => 1.hour.ago, :end_time => 29.minutes.ago
      Raffle.for_update.should == [r]
    end

    it 'should not return raffles that ended more than 30 minutes ago' do
      r = Factory :raffle, :start_time => 1.hour.ago, :end_time => 31.minutes.ago
      Raffle.for_update.should be_blank
    end
  end
end

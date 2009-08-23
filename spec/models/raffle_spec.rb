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
  specify { @it.should belong_to(:winner) }

  %w(prize start_time end_time hashtag).each do |attr|
    specify { @it.should validate_presence_of(attr) }
  end

  it 'should validate format of hashtag' do
    ['5am', 'railsrumble', 'looooooooongbutvalid'].each do |valid|
      @it.should validate_format_of(:hashtag).with(valid)
    end
    ['foo-bar', 'foo bar', 'toooooooooooolong'].each do |invalid|
      @it.should validate_format_of(:hashtag).not_with(invalid).
        with_message('must be 16 chars max. Letters or digits only')
    end
  end

  it 'should strip out leading hash symbol' do
    @it.hashtag = '#5am'
    @it.hashtag.should == '5am'
  end

  describe 'when responding to status check methods' do
    before(:each) do
      @active = Raffle.new(:start_time => 2.minutes.ago, :end_time => 2.minutes.from_now)
      @ended  = Raffle.new(:start_time => 3.minutes.ago, :end_time => 1.minute.ago)
      @future = Raffle.new(:start_time => 2.minutes.from_now, :end_time => 3.minutes.from_now)
    end

    it 'should respond to active?' do
      @active.should be_active
      @ended.should_not be_active
      @future.should_not be_active
    end

    it 'should respond to ended?' do
      @ended.should be_ended
      @active.should_not be_ended
      @future.should_not be_ended
    end

    it 'should respons to future?' do
      @future.should be_future
      @active.should_not be_future
      @ended.should_not be_future
    end
  end

  it 'should have "active" named scope' do
    Factory :raffle, :start_time => 1.minute.from_now
    Factory :raffle, :start_time => 3.days.ago, :end_time => 1.day.ago
    Raffle.active.should be_empty
    r = Factory :raffle, :start_time => 1.minute.ago, :end_time => 1.minute.from_now
    Raffle.active.should == [r]
  end

  it 'should have "inactive" named scope' do
    Factory :raffle, :start_time => 1.minute.ago, :end_time => 1.minute.from_now
    Raffle.inactive.should be_empty
    r1 = Factory :raffle, :start_time => 1.minute.from_now
    r2 = Factory :raffle, :start_time => 3.days.ago, :end_time => 1.day.ago
    Raffle.inactive.should == [r1, r2]
  end

  describe 'on validation' do
    it 'should change the end time to be the end of the day' do
      @it.end_time = '23 August'
      @it.end_time.strftime('%H:%M').should == '00:00'
      @it.valid?
      @it.end_time.strftime('%H:%M').should == '23:59'
    end
  end

  describe 'when selecting winner' do
    before(:each) do
      @it = Factory :raffle
      3.times { Factory :participant, :raffle => @it }
      @it.winner.should be_nil
    end

    it 'should pick one of the participants' do
      @it.pick_winner!
      @it.winner.should_not be_nil
      @it.participants.should include(@it.winner)
    end

    it 'should mark the participant as winner' do
      @it.pick_winner!
      @it.reload
      @it.winner.should be_winner
    end

    it 'should reset winner flag if all participants have been selected as winners' do
      3.times { @it.pick_winner! }
      @it.participants.loosers.should be_empty
      @it.pick_winner!
      @it.reload
      @it.participants.loosers.count.should == 2
      @it.winner.should be_winner
    end
  end
end

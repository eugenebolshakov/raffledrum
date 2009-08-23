require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RaffleUpdateJob do
  before(:each) do
    @raffle = Factory :raffle
    @it = RaffleUpdateJob.new(@raffle.id)
    @updater = mock('RaffleUpdater', :update => nil)
    RaffleUpdater.stub!(:new).and_return(@updater)
  end

  def scheduled_job_time
    Delayed::Job.count.should be_zero
    @it.perform
    job = Delayed::Job.first
    job.payload_object.should == @it
    job.run_at
  end

  describe 'if the raffle starts in the future' do
    before(:each) do
      @raffle.update_attribute(:start_time, 2.minutes.from_now)
    end

    it 'should not update the ruffle' do
      RaffleUpdater.should_not_receive(:new)
      @it.perform
    end

    it 'should schedule the next run after it starts' do
      scheduled_job_time.to_s.should == (@raffle.start_time + RaffleUpdateJob::INTERVAL).to_s
    end
  end

  describe 'if the raffle started' do 
    before(:each) do
      @raffle.update_attribute(:start_time, 1.minute.ago)
    end

    it 'should init the updater with the raffle' do
      RaffleUpdater.should_receive(:new).with(@raffle).and_return(@updater)
      @it.perform
    end

    it 'should update the raffle' do
      @updater.should_receive(:update)
      @it.perform
    end

    describe 'if the raffle ended' do
      it 'should not schedule the job anymore' do
        @raffle.update_attribute(:end_time, 1.minute.ago)
        lambda { @it.perform }.should_not
          change { Delayed::Job.count }
      end
    end

    describe 'if the raffle is active' do
      describe 'and does not end soon' do
        it 'should schedule the next run using the interval' do
          @raffle.update_attribute(:end_time, 1.hour.from_now)
          scheduled_job_time.to_i.should == (Time.now + RaffleUpdateJob::INTERVAL).to_i
        end
      end

      describe 'and ends soon' do
        it 'should schedule the job on raffle end date' do
          @raffle.update_attribute(:end_time, 1.minute.from_now)
          scheduled_job_time.to_i.should == @raffle.end_time.to_i
        end
      end
    end
  end
end

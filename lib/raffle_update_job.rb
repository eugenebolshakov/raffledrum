class RaffleUpdateJob < Struct.new(:id)
  INTERVAL = 5.minutes

  def perform
    raffle = Raffle.find(id)
    RaffleUpdater.new(raffle).update
    if raffle.active?
      curr_time = Time.now
      schedule_time = curr_time + INTERVAL >= raffle.end_time ? 
        raffle.end_time :
        curr_time + INTERVAL
      Delayed::Job.enqueue(RaffleUpdateJob.new(raffle.id), 1, schedule_time)
    elsif raffle.future?
      Delayed::Job.enqueue(RaffleUpdateJob.new(raffle.id), 1, raffle.start_time)
    end
  end
end

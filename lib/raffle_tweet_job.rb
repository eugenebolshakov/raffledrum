class RaffleTweetJob < Struct.new(:id)
  def perform
    raffle = Raffle.find(id)
    if raffle.future?
      Delayed::Job.enqueue(RaffleTweetJob.new(raffle.id), 2, raffle.start_time + INTERVAL)
    else
      ad = ApplicationController.helpers.strip_tags(ApplicationController.helpers.raffle_ad(raffle))
      TwitterBot.find_by_login('raffledrum').twitter.post!(ad)
    end
  end
end

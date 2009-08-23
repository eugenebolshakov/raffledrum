class RaffleTweetJob < Struct.new(:id)
  def perform
    raffle = Raffle.find(id)
    if raffle.future?
      Delayed::Job.enqueue(RaffleTweetJob.new(raffle.id), 2, raffle.start_time + INTERVAL)
    else
      ad = ApplicationController.helpers.strip_tags(ApplicationController.helpers.raffle_ad(raffle))
      TwitterBot.find_by_login('raffledrum').twitter.post!(ad)
      TwitterBot.find_by_login('raffledrum_test').twitter.post!("I wanna win #{raffle.prize}! ##{raffle.hashtag}")
      TwitterBot.find_by_login('raffledrum_tes2').twitter.post!("I wanna win #{raffle.prize} too! ##{raffle.hashtag}")
    end
  end
end

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def twitter_user_url(participant)
    "http://twitter.com/#{participant.twitter_login}"
  end

  def twitter_status_url(participant)
    "http://twitter.com/#{participant.twitter_login}/status/#{participant.tweet_id}"
  end

  def raffle_time(raffle)
    if raffle.active?
      "Ends in #{distance_of_time_in_words(Time.now, raffle.end_time)}"
    elsif raffle.ended?
      "Ended #{time_ago_in_words(raffle.end_time)} ago"
    elsif raffle.future?
      "Starts in #{distance_of_time_in_words(Time.now, raffle.start_time)}"
    end
  end
end

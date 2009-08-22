# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def twitter_user_url(participant)
    "http://twitter.com/#{participant.twitter_login}"
  end

  def twitter_status_url(participant)
    "http://twitter.com/#{participant.twitter_login}/status/#{participant.tweet_id}"
  end
end

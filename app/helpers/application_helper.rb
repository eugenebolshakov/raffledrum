# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def twitter_user_url(user)
    login = user.is_a?(Participant) ? user.twitter_login : user
    "http://twitter.com/#{login}"
  end

  def twitter_status_url(participant)
    "http://twitter.com/#{participant.twitter_login}/status/#{participant.tweet_id}"
  end

  def tweet_message_url(message)
    "http://twitter.com/home?status=#{CGI.escape(message)}"
  end

  def raffle_time(raffle)
    if raffle.active?
      "Ends in #{distance_of_time_in_words(Time.zone.now, raffle.end_time)}"
    elsif raffle.ended?
      "Ended #{time_ago_in_words(raffle.end_time)} ago"
    elsif raffle.future?
      "Starts in #{distance_of_time_in_words(Time.zone.now, raffle.start_time)}"
    end
  end

  def format_date(date)
    date.strftime('%d %b, %y') if date
  end

  def raffle_ad(raffle)
    "Win #{raffle.prize}! Follow " <<
    link_to("@#{raffle.user.login}", twitter_user_url(raffle.user.login), :target => '_blank') <<
    " and " <<
    link_to("tweet ##{raffle.hashtag}", tweet_message_url("##{raffle.hashtag}"), :target => '_blank')
  end

  def google_analytics
<<GA
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-10352909-1");
pageTracker._trackPageview();
} catch(err) {}</script>
GA
  end
end

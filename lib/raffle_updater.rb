class RaffleUpdater
  def initialize(raffle)
    @raffle = raffle
  end

  def update
    options = {}
    options[:since_id] = @raffle.last_tweet_id
    search = TwitterSearch.new("##{@raffle.hashtag}", options)
    search.each do |result|
      if valid_tweet?(result)
        @raffle.participants.create(
          :twitter_user_id => result['from_user_id'],
          :twitter_login   => result['from_user'],
          :twitter_image   => result['profile_image_url'],
          :tweet           => result['text'],
          :tweet_id        => result['id'],
          :posted_at       => result['created_at']
        )
      end
    end
    @raffle.update_attribute('last_tweet_id', search.last_tweet_id)
  end

  private

    def valid_tweet?(tweet)
      time = Time.parse(tweet['created_at'])
      time >= @raffle.start_time &&
      time <= @raffle.end_time &&
      tweet['from_user'] != 'raffledrum' &&
      tweet['from_user_id'] != @raffle.user.twitter_id
      # &&
      # @raffle.user.followers.include?(tweet['from_user_id'])
    end

end

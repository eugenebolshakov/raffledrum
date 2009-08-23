Factory.define :participant do |p|
  p.sequence(:twitter_user_id) { |i| "#{i}" }
  p.twitter_login              'onetwo'
  p.twitter_image              '/images/spacer.gif'
  p.tweet                      'hey'
  p.tweet_id                   '1234567'
  p.posted_at                  { Time.now }
  p.raffle                     nil
  p.winner                     false
end

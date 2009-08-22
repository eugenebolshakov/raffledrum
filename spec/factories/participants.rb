Factory.define :participant do |p|
  p.twitter_user_id '123456'
  p.twitter_login   'onetwo'
  p.tweet           'hey'
  p.tweet_id        '1234567'
  p.posted_at       { Time.now }
  p.raffle          nil
end

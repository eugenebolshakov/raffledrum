require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do
  it 'should return twitter user url' do
    p = Factory.build :participant, :twitter_login => 'eugenebolshakov'
    helper.twitter_user_url(p).should == "http://twitter.com/eugenebolshakov"
    helper.twitter_user_url('eugenebolshakov').should == "http://twitter.com/eugenebolshakov"
  end

  it 'should return status url' do
    p = Factory.build :participant, :twitter_login => 'ej', :tweet_id => '123456'
    helper.twitter_status_url(p).should == 'http://twitter.com/ej/status/123456'
  end

  it 'should return a url to tweet someting' do
    helper.tweet_message_url('foo bar').should == 'http://twitter.com/home?status=foo+bar'
  end

  it 'should return raffle time' do
    r = Raffle.new(:start_time => 1.minute.ago, :end_time => 1.minute.from_now)
    helper.raffle_time(r).should == "Ends in 1 minute"
    r = Raffle.new(:start_time => 3.minutes.ago, :end_time => 2.minute.ago)
    helper.raffle_time(r).should == "Ended 2 minutes ago"
    r = Raffle.new(:start_time => 3.minutes.from_now, :end_time => 4.minutes.from_now)
    helper.raffle_time(r).should == "Starts in 3 minutes"
  end

  it 'should return raffle ad' do
    r = Raffle.new(:prize => 'iPhone', :hashtag => '#iwannaiphone')
    r.user = User.new(:login => 'iphone')
    ad = "Win iPhone! Follow "
    ad << link_to('@iphone', helper.twitter_user_url('iphone'), :target => '_blank')
    ad << " and "
    ad << link_to("tweet #iwannaiphone", helper.tweet_message_url("#iwannaiphone"), :target => '_blank')
    helper.raffle_ad(r).should == ad
  end
end

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do
  it 'should return twitter user url' do
    p = Factory.build :participant, :twitter_login => 'eugenebolshakov'
    helper.twitter_user_url(p).should == "http://twitter.com/eugenebolshakov"
  end

  it 'should return status url' do
    p = Factory.build :participant, :twitter_login => 'ej', :tweet_id => '123456'
    helper.twitter_status_url(p).should == 'http://twitter.com/ej/status/123456'
  end
end

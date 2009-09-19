require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class MockTwitterSearch
  attr_accessor :results

  def initialize(results = [])
    @results = results
  end

  def each
    @results.each { |r| yield r }
  end

  def last_tweet_id; end
end

describe RaffleUpdater do
  before(:each) do
    @raffle = Factory :raffle
    @raffle.user = User.new
    @raffle.user.stub!(:followers).and_return(['123456'])
    @it = RaffleUpdater.new(@raffle)
    @search = MockTwitterSearch.new
    TwitterSearch.stub!(:new).and_return(@search)
  end

  describe 'on search' do
    it 'should query twitter by raffle hashtag' do
      TwitterSearch.should_receive(:new).with("##{@raffle.hashtag}", an_instance_of(Hash)).and_return(@search)
      @it.update
    end

    it 'should use the last tweet id' do
      @raffle.last_tweet_id = '666'
      TwitterSearch.should_receive(:new).with("##{@raffle.hashtag}", {:since_id => '666'}).and_return(@search)
      @it.update
    end
  end

  describe 'when parsing results' do
    def tweet(override = {})
      {
        'id'                => '1234567',
        'from_user_id'      => '123456',
        'from_user'         => 'onetwo',
        'profile_image_url' => 'http://www.google.com/logo.png',
        'text'              => 'Tweeet',
        'created_at'        =>  (@raffle.start_time + 5.minutes).to_s
      }.merge(override)
    end

    before(:each) do
    end

    it 'should ignore tweets that do not fall into the raffle timeframe' do
      @search.results = [
        tweet('created_at' => (@raffle.start_time - 1.minute).to_s),
        tweet('created_at' => (@raffle.end_time + 1.minute).to_s)
      ]
      @it.update
      @raffle.reload.participants.should be_empty
    end

    it 'should ignore tweets from raffledrum' do
      @search.results = [
        tweet('from_user' => 'raffledrum')
      ]
      @it.update
      @raffle.reload.participants.should be_empty
    end

    it 'should ignore tweets from raffle owner' do
      @raffle.user.twitter_id = '1234'
      @search.results = [
        tweet('from_user_id' => '1234')
      ]
      @it.update
      @raffle.reload.participants.should be_empty
    end

    # it 'should ignore tweets from people who do not follow the raffle creator' do
    #   @raffle.user.stub!(:followers).and_return(['12', '123', '1234'])
    #   @search.results = [
    #     tweet('from_user_id' => '12345'),
    #     tweet('from_user_id' => '12')
    #   ]
    #   @it.update
    #   @raffle.reload.participants.size.should == 1
    #   @raffle.participants.first.twitter_user_id.should eql('12')
    # end

    it 'should not add multiple tweets for the same user' do
      @search.results = [
        tweet, tweet, tweet
      ]
      @it.update
      @raffle.reload.participants.size.should == 1
    end

    it 'should store all tweet details' do
      t = tweet
      @search.results = [ t ]
      @it.update
      participant = @raffle.reload.participants.first
      {
        'twitter_user_id' => 'from_user_id',
        'twitter_login'   => 'from_user',
        'twitter_image'   => 'profile_image_url',
        'tweet'           => 'text',
        'tweet_id'        => 'id',
        'posted_at'       => 'created_at'
      }.each do |db, twitter|
        participant.send(db).to_s.should eql(t[twitter])
      end
    end
  end

  it 'should update last tweet id' do
    @raffle.last_tweet_id = '666'
    @search.stub!(:last_tweet_id).and_return('777')
    @it.update
    @raffle.reload.last_tweet_id.should == '777'
  end

end

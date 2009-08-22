require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TwitterSearch do
  before(:each) do
    FakeWeb.register_uri(
      :get, 
      'http://search.twitter.com/search.json?rpp=100&q=keyword',
      :response => File.join(RAILS_ROOT, 'spec', 'fixtures', 'search.json')
    )
    @it = TwitterSearch.new('keyword')
  end

  describe 'should return results that' do
    before(:each) do
      @results = @it.results
    end

    it 'should have 100 entries per page' do
      @results['results'].size.should == 100
    end
  end

  it 'should fetch results one by one' do
    results = []
    @it.each do |r|
      results << r
    end
    results.size.should == 100
  end

  it 'should return the id of the last tweet' do
    @it.last_tweet_id.to_s.should == '3468301400'
  end

end

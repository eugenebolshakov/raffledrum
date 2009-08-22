require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @it = User.new
  end

  specify { @it.should have_many(:raffles) }

  it 'should return followers' do
    FakeWeb.register_uri(:get, 'https://twitter.com/followers/ids.json', :body => '[12, 123]')
    @it.followers.should == %w(12 123)
  end
end

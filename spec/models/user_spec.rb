require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @it = User.new
  end

  specify { @it.should have_many(:raffles) }
end

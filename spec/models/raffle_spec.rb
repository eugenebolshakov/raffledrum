require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Raffle do
  before(:each) do
    @it = Raffle.new
  end

  %w(prize start_time end_time hashtag).each do |attr|
    specify { @it.should allow_mass_assignment_of(attr) }
  end

  specify { @it.should belong_to(:user) }

  %w(prize start_time end_time hashtag).each do |attr|
    specify { @it.should validate_presence_of(attr) }
  end

end

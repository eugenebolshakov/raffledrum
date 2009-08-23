Given /^I have a raffle with hashtag "([^\"]*)"$/ do |hashtag|
  @raffle = Factory :raffle, :hashtag => hashtag, :user => current_user
end

Given /^there are (\d+) participants?$/ do |number|
  number.to_i.times { Factory :participant, :raffle => @raffle }
end

Given /^the raffle has ended$/ do
  @raffle.update_attribute(:end_time, 1.minute.ago)
end

Given /the winner is selected$/ do
  @raffle.pick_winner!
end

Then /^a raffle with hashtag "([^\"]*)" should exist$/ do |hashtag|
  @raffle = Raffle.find_by_hashtag(hashtag)
  @raffle.should_not be_nil
end

Then /^a job to update the raffle should be scheduled$/ do
  job = Delayed::Job.find(:first, :order => 'id')
  job.name.should == 'RaffleUpdateJob'
  job.payload_object[:id].should == @raffle.id
end

Then /^a job to pick a winner should be scheduled$/ do
  job = Delayed::Job.find(:first, :order => 'id DESC')
  job.name.should == 'RafflePickWinnerJob'
  job.payload_object[:id].should == @raffle.id
  job.run_at.should == @raffle.end_time
end

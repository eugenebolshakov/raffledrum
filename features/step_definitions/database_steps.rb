Given /^I have a raffle with hashtag "([^\"]*)"$/ do |hashtag|
  @raffle = Factory :raffle, :hashtag => hashtag, :user => current_user
end

Given /^there are (\d+) participants?$/ do |number|
  number.to_i.times { Factory :participant, :raffle => @raffle }
end

Then /^a raffle with hashtag "([^\"]*)" should exist$/ do |hashtag|
  Raffle.find_by_hashtag(hashtag).should_not be_nil
end

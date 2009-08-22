Given /^I have a raffle with hashtag "([^\"]*)"$/ do |hashtag|
  Factory :raffle, :hashtag => hashtag
end

Then /^a raffle with hashtag "([^\"]*)" should exist$/ do |hashtag|
  Raffle.find_by_hashtag(hashtag).should_not be_nil
end

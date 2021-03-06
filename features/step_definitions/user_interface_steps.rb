Given /^I am logged in$/ do
  visit login_path
  visit oauth_callback_path
end

When /^I select a different winner$/ do
  visit change_winner_my_raffle_path(@raffle), :put
end

Then /^I should be asked to log in with my twitter account$/ do
  response.redirect_url.should eql(
    'https://twitter.com/oauth/authenticate?oauth_token=fake&oauth_callback=http%3A%2F%2Flocalhost%3A3000%2Foauth_callback'
  )
end

Then /^I should see raffle details$/ do
  within "#raffle-#{@raffle.id}" do |scope|
    scope.should contain("#{@raffle.participants.size} participants")
  end
end

Then /^I should see the participants$/ do
  @raffle.participants.each do |participant|
    within ".participant#participant-#{participant.id}" do |scope|
      scope.should contain(participant.tweet)
    end
  end
end

Then /^I should see the winner$/ do
  within ".winner .participant#participant-#{@raffle.winner.id}" do |scope|
    scope.should contain(@raffle.winner.tweet)
  end
end

Then /^I should be redirected to (.+)$/ do |page_name|
  (response.redirect_url || request.path).should == path_to(page_name)
end

Then /^I should see the raffle$/ do
  within "#raffle-#{@raffle.id}" do |scope|
    scope.should contain("##{@raffle.hashtag}")
  end
end

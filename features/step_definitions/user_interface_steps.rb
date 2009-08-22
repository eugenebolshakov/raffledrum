Given /^I am logged in$/ do
  visit login_path
  visit oauth_callback_path
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

Feature: Homepage

  Background:
    Given I am logged in

  Scenario: I do not have any raffles
    When I go to the homepage
    Then I should be redirected to the new raffle page

  Scenario: I have a raffle
    Given I have a raffle with hashtag "iwannaiphone"
    When I go to the homepage
    Then I should be redirected to the list of my raffles

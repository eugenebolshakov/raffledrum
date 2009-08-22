Feature: View Raffles

  Background:
    Given I am logged in

  Scenario: View Raffles
    Given I have a raffle with hashtag "iwannaipod"
    When I go to the list of my raffles
    Then I should see "#iwannaipod"

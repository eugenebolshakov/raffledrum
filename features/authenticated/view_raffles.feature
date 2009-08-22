Feature: View Raffles

  Background:
    Given I am logged in
    And I have a raffle with hashtag "iwannaipod"

  Scenario: View Raffles
    When I go to the list of my raffles
    Then I should see "#iwannaipod"

  Scenario: Raffle Details
    Given there are 2 participants
    When I go to the list of my raffles
    Then I should see raffle details

  Scenario: View Raffle Participants
    Given there are 2 participants
    When I go to the list of my raffles
    And I follow "#iwannaipod"
    Then I should see the participants

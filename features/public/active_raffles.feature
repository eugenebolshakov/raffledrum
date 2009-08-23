Feature: Active Raffles

  Scenario: Active Raffles List
    Given there is a raffle with hashtag "#iwannaiphone"
    And the raffle is active
    When I go to the list of active raffles
    Then I should see the raffle

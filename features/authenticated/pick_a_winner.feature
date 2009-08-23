Feature: Pick a winner

  Background:
    Given I am logged in
    And I have a raffle with hashtag "#iwannaipod"
    And there are 3 participants
    And the raffle has ended

  Scenario: Winner is not selected yet
    When I go to the list of participants
    Then I should see "The winner is not selected yet"

  Scenario: Winner is selected
    Given the winner is selected
    When I go to the list of participants
    Then I should see the winner




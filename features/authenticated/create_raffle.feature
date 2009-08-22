Feature: Create Raffle

  Background:
    Given I am logged in

  Scenario: Create Raffle
    When I go to the new raffle page
    And I fill in "Prize" with "iPod"
    And I fill in "Start Time" with "22 August 2009"
    And I fill in "End Time" with "23 August 2009"
    And I fill in "Hashtag" with "iwannaipod"
    And I press "Create Raffle"
    Then I should see "Raffle has been created"
    And a raffle with hashtag "iwannaipod" should exist

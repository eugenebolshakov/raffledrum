Feature: Homepage

  Scenario: I am not logged in and I open the homepage
    When I go to the homepage
    Then I should see "Create your twitter raffle"

  Scenario: I try to create a raffle
    When I go to the homepage
    And I follow "Create your twitter raffle"
    Then I should be asked to log in with my twitter account

  Scenario: One active raffle on the homepage
    Given there is a raffle with hashtag "#iwannaiphone"
    And the raffle is active
    When I go to the homepage
    Then I should see the raffle

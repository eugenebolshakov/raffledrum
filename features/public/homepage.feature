Feature: Homepage

  Scenario: I am not logged in and I open the homepage
    When I go to the homepage
    Then I should see "Create your twitter raffle"

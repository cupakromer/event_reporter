Feature: Issuing the 'queue count' command will output the number of records

  As a user
  In order to know how many records have been loaded
  I will run the 'queue count' command

  Scenario: Queue Count
    Given I am at the command prompt with default data loaded
    When I issue the command "queue count"
    Then I should see "10 attendees in queue"



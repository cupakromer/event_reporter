Feature: Issuing the 'load' command will load CSV data

  As a user
  In order to get data that I need to analyze
  I will run the 'load' command passing an optional file name,
  If no name is given then a default event_attendees.csv file is used.

  Scenario: Load a specified data file
    Given I am at the command prompt
    When I issue the command "load my_attendees.csv"
    Then I should see a message "10 attendees loaded"

  Scenario: Load the default data file
    Given I am at the command prompt
    When I issue the command "load"
    Then I should see a message "5175 attendees loaded"

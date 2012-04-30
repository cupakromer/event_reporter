@ignore
Feature: execution sequences for base expectations

  Scenario: Happy Path
    Given the event attendees are loaded
    Then issuing "queue count" should return 0
    And issuing "find first_name John" should cause "queue count" to be 63
    And issuing "queue clear" should cause "queue count" to be 0
    And issuing "help" should list the commands
    And issuing "help queue count" should explain the queue count function
    And issuing "help queue print" should explain the print function

  Scenario: Let's Try Printing
    Given the default event attendees are loaded
    Then issuing "queue count" should return 0
    And issuing "find first_name John" followed by "find first_name Mary" should cause "queue print" to print out 16 attendees
    And issuing "queue print by last_name" should print the same attendees sorted alphabetically by last name
    And issuing "queue count" should return 16

  Scenario: Saving
    Given the default event attendees are loaded
    Then issuing "find city Salt Lake City" should cause "queue print" to display 13 attendees
    And issuing "queue save to city_sample.csv" should create city_sample.csv
    And issuing "find state DC" should cause "queue print by last_name" to display X attendees' last names
    And issuing "queue save to state_sample.csv" should create state_sample.csv

  Scenario: Reading Your Data
    Given the default event attendees are loaded
    And issuing "find state MD"
    And issuing "queue save to state_sample.csv"
    And issuing "quit"
    # Restart the program and continue...
    When I run the program
    And issuing "load state_sample.csv"
    And issuing "find first_name John"
    Then "queue count" should return 4

  Scenario: Emptiness
    # Note that this set intentionally has no call to load
    Given I run the program
    Then issuing "find last_name Johnson" should cause "queue count" to return 0
    And issuing "queue print" should not print any attendee data
    And issuing "queue clear" should not return an error
    And issuing "queue print by last_name" should not print any data
    And issuing "queue save to empty.csv" should output a file with only headers
    And issuing "queue count" should return 0

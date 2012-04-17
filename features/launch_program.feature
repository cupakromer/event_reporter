Feature: program is launched

  As a user
  I want to launch the program to receive a command prompt
  Where I can issue one of several commands

  Scenario: program is run
    Given I am have not launched the program
    When I run the program
    Then I should see "Welcome to Event Reporter!"
    And I should see the command prompt


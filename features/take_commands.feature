Feature: Take commands from the user

  As a user
  At the command prompt
  I can issue one of several commands

  Background:
    Given I am at the command prompt

  Scenario: command prompt gives notification on invalid command
    When I enter an invalid command
    Then I should see "Sorry, I don't know that command"

  Scenario: command prompt gives 'help' command option on invalid command
    When I enter an invalid command
    Then I should see "Use the command 'help' to see a list of all valid commands"


Feature: Issuing the 'help' command will provide information

  As a user
  In order to get help with various commands
  I will run the 'help' command passing an optional command name

  Scenario: List all available commands
    Given I am at the command prompt
    When I issue the command "help"
    Then I should see a list of all available commands

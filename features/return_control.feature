Feature: Return control to user

  As a user
  After each command completes
  The prompt returns, waiting for another instruction.

  Scenario: any valid or invalid command returns control
    Given I am at the command prompt
    When I enter any command
    Then I should see the command prompt again



Feature: Return control to user

  As a user
  After each command completes
  The prompt returns, waiting for another instruction.

  Scenario: any command (valid or invalid) returns control to user
    Given I am at the command prompt
    When I enter any command
    Then I should see the command prompt again


Feature: Issuing the 'help' command will provide information

  As a user
  In order to get help with various commands
  I will run the 'help' command passing an optional command name

  Scenario: List all available commands
    Given I am at the command prompt
    When I issue the command "help"
    Then I should see a list of all available commands

  Scenario Outline: Describe how to use specific command
    Given I am at the command prompt
    When I issue the command "help <command>"
    Then I should see "<description>"

    Scenarios: load command
       | command | description                                                                                                  |
       | load    | Erase any loaded data and parse the specified file. If no filename is given, default to event_attendees.csv. |

    Scenarios: queue commands
      | command        | description                                                  |
      | queue count    | Output how many records are in the current queue.            |
      | queue clear    | Empty the queue.                                             |
      | queue print    | Print out a tab-delimited data table with a header row.      |
      | queue print by | Print the data table sorted by the specified attribute.      |
      | queue save to  | Export the current queue to the specified filename as a CSV. |

    Scenarios: find command
       | command | description                                                                    |
       | find    | Load the queue with all records matching the criteria for the given attribute. |

  Scenario: Request help on invalid command
    Given I am at the command prompt
    When I issue the "help" command for an invalid command
    Then I should see "Sorry, I don't know that command"
    And I should see "Use the command 'help' to see a list of all valid commands"

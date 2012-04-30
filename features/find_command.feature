Feature: Issuing the 'find' command will load the queue with all matching records

  As a user
  In order to get just the data that I am looking for
  I will run the 'find <attribute> <criteria>' command
  To load the queue with all records matching the criteria for the given attribute.

  Comparison of the criteria will:
  * Be insensitive to case, so "Mary" and "mary" would be found together
  * Be insensitive to internal whitespace, but not external:
    - "John" and "John " are considered matches
    - "John Paul" and "Johnpaul" are not matches
  * Does not match on substrings, so `find first_name Mary` does not find a
    record with first name "marybeth"

  Scenario: Insensitive to case
    Given the "my_attendees.csv" attendees are loaded
    When I issue the command "find first_name saRaH"
    And I issue the command "queue print"
    Then I should see "2 attendees loaded"
    And I should see the data table:
       | LAST NAME | FIRST NAME | EMAIL                             | ZIPCODE | CITY             | STATE | ADDRESS                | PHONE          |
       | Hankins   | Sarah      | pinalevitsky@jumpstartlab.com     | 20009   | Washington       | DC    | 2022 15th Street NW    | 4145205000   |
       | Xx        | Sarah      | lqrm4462@jumpstartlab.com         | 33703   | Saint Petersburg | FL    | 4175 3rd Street North  | 9419792000  |

  Scenario: Insensitive to internal whitespace - match
    Given the "my_attendees.csv" attendees are loaded
    When I issue the command "find first_name mary"
    And I issue the command "queue print"
    Then I should see "1 attendees loaded"
    And I should see "Mary Kate"

  Scenario: Insensitive to internal whitespace - no match
    Given the "my_attendees.csv" attendees are loaded
    When I issue the command "find first_name marykate"
    Then I should see "0 attendees loaded"

  Scenario: No match on substring
    Given the "my_attendees.csv" attendees are loaded
    When I issue the command "find city la"
    And I issue the command "queue print"
    Then I should see "1 attendees loaded"
    And I should see "La Jolla"
    And I should not see "Placerville"

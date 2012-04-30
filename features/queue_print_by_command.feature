Feature: Issuing the 'queue print by' command will output a sorted data table

  As a user
  In order to see data in a useful manner
  I will run the 'queue print by' command passing an attribute
  And get a tab delimited table sorted descending by that attribute

  Scenario: Sorted Tab Delimited Table
    Given the "my_attendees.csv" attendees are loaded
    When I issue the command "queue print by last_name"
    Then I should see the ordered data table:
       | LAST NAME | FIRST NAME | EMAIL                             | ZIPCODE | CITY             | STATE | ADDRESS                | PHONE          |
       | Armideo   | Shiyu      | odfarg06@jumpstartlab.com         | 96734   | Kailua           | HI    | 644 Ikemaka PL         | 8084974000     |
       | Cope      | Jennifer   | bjgielskil@jumpstartlab.com       | 00000   | Nashville        | TN    | 1133 Shelton Ave       | 7048133000   |
       | Curry     | Mary Kate  | wmppydaymaker@jumpstartlab.com    | 21230   | Baltimore        | MD    | 1509 Jackson Street    | 2023281000 |
       | Fuller    | Aya        | jtex@jumpstartlab.com             | 90210   | Vancouver        | BC    | 2-1325 Barclay Street  | 7782327000   |
       | Hankins   | Sarah      | pinalevitsky@jumpstartlab.com     | 20009   | Washington       | DC    | 2022 15th Street NW    | 4145205000   |
       | Hasegan   | Audrey     | ffbbieucf@jumpstartlab.com        | 95667   | Placerville      | CA    | 1570 Old Ranch Rd.     | 5309193000   |
       | Nguyen    | Allison    | arannon@jumpstartlab.com          | 20010   | Washington       | DC    | 3155 19th St NW        | 6154385000     |
       | Xx        | Sarah      | lqrm4462@jumpstartlab.com         | 33703   | Saint Petersburg | FL    | 4175 3rd Street North  | 9419792000  |
       | Zielke    | Eli        | jbrabeth.buckley@jumpstartlab.com | 00037   | La Jolla         | CA    | 3024 Cranbrook Ct      | 8584053000   |
       | Zimmerman | Douglas    | vjeller.79@jumpstartlab.com       | 50309   | Des Moines       | IA    | 1818 Woodland Ave #101 | 4252745000   |

  Scenario: Passing a bad attribute fails with message
    Given the "my_attendees.csv" attendees are loaded
    When I issue the command "queue print by no_such_attribute"
    Then I should see "Unknown attribute 'no_such_attribute'"

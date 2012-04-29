Feature: Issuing the 'queue print' command will output a data table

  As a user
  In order see the data that I have queue
  I will run the 'queue print' command to get a tab delimited table

  Scenario: Tab Delimited Table
    Given the "my_attendees.csv" attendees are loaded
    When I issue the command "queue print"
    Then I should see the data table:
       | LAST NAME | FIRST NAME | EMAIL                             | ZIPCODE | CITY             | STATE | ADDRESS                | PHONE          |
       | Nguyen    | Allison    | arannon@jumpstartlab.com          | 20010   | Washington       | DC    | 3155 19th St NW        | 6154385000     |
       | Hankins   | Sarah      | pinalevitsky@jumpstartlab.com     | 20009   | Washington       | DC    | 2022 15th Street NW    | 4145205000   |
       | Xx        | Sarah      | lqrm4462@jumpstartlab.com         | 33703   | Saint Petersburg | FL    | 4175 3rd Street North  | 9419792000  |
       | Cope      | Jennifer   | bjgielskil@jumpstartlab.com       | 00000   | Nashville        | TN    | 1133 Shelton Ave       | 7048133000   |
       | Zimmerman | Douglas    | vjeller.79@jumpstartlab.com       | 50309   | Des Moines       | IA    | 1818 Woodland Ave #101 | 4252745000   |
       | Fuller    | Aya        | jtex@jumpstartlab.com             | 90210   | Vancouver        | BC    | 2-1325 Barclay Street  | 7782327000   |
       | Curry     | Mary Kate  | wmppydaymaker@jumpstartlab.com    | 21230   | Baltimore        | MD    | 1509 Jackson Street    | 2023281000 |
       | Hasegan   | Audrey     | ffbbieucf@jumpstartlab.com        | 95667   | Placerville      | CA    | 1570 Old Ranch Rd.     | 5309193000   |
       | Armideo   | Shiyu      | odfarg06@jumpstartlab.com         | 96734   | Kailua           | HI    | 644 Ikemaka PL         | 8084974000     |
       | Zielke    | Eli        | jbrabeth.buckley@jumpstartlab.com | 00037   | La Jolla         | CA    | 3024 Cranbrook Ct      | 8584053000   |

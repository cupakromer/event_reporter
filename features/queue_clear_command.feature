Feature: Issuing the 'queue clear' command emptys attendee list

  As a user
  In order to empty out the list of attendees
  I will run the 'queue clear' command

  Scenario: Queue Clear
    Given the default attendees are loaded
    When I issue the command "queue clear"
    Then I should see "Attendee queue is empty"
    And issuing "queue count" should return "0 attendees in queue"

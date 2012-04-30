Event Reporter
=========
This is my work through of the [Jumpstart Labs](http://jumpstartlab.com/)
Ruby exericse [Event Reporter](https://github.com/JumpstartLab/curriculum/blob/master/source/projects/event_reporter.markdown).

The approach I am taking for this is to try some BDD using [Cucumber](http://cukes.info/)
and [RSpec](http://rspec.info/).


#### Command Prompt Instructions

##### `load <filename>`

Erase any loaded data and parse the specified file. If no filename is given, default to `event_attendees.csv`.

##### `help`

Output a listing of the available individual commands
 
##### `help <command>`

Output a description of how to use the specific command. For example:

```
help queue clear
help find
```

##### `queue count`

Output how many records are in the current queue

##### `queue clear`

Empty the queue

##### `queue print`

Print out a tab-delimited data table with a header row following this format:

```
  LAST NAME  FIRST NAME  EMAIL  ZIPCODE  CITY  STATE  ADDRESS  PHONE
```

##### `queue print by <attribute>`

Print the data table sorted by the specified `attribute` like `zipcode`.

##### `queue save to <filename.csv>`

Export the current queue to the specified filename as a CSV. The file should should include data and headers for last name, first name, email, zipcode, city, state, address, and phone number.

##### `find <attribute> <criteria>`

Load the queue with all records matching the criteria for the given attribute. Example usages:

* `find zipcode 20011`
* `find last_name Johnson`
* `find state VA`

The comparison should:

* Be insensitive to case, so `"Mary"` and `"mary"` would be found in the same search
* Be insensitive to internal whitespace, but not external:
  * `"John"` and `"John "` are considered matches
  * `"John Paul"` and `"Johnpaul"` are not matches
* Not do substring matches, so a `find first_name Mary` does not find a record with first name `"marybeth"`
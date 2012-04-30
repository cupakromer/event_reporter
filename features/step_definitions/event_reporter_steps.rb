class Output
  def messages
    @messages ||= []
  end

  def puts(message)
    messages << message
  end

  def clear
    @messages = []
  end
end

def output
  @output ||= Output.new
end

DEFAULT_DATA_FILE = "event_attendees.csv"

Given /^I have not launched the program$/ do
  # Do nothing, we have no program to do anything with now.
end

Given /^I am at the command prompt$/ do
  @app = Event::Reporter.new(output)
  @app.run
  output.messages.last.should include "Command: "
end

Given /^the default attendees are loaded$/ do
  @app = Event::Reporter.new(output)
  @app.run
  @app.execute "load #{DEFAULT_DATA_FILE}"
  output.messages.last.should include "Command: "
end

Given /^the "([^"]*)" attendees are loaded$/ do |file|
  @app = Event::Reporter.new(output)
  @app.run
  @app.execute "load #{file}"
  output.messages.last.should include "Command: "
end

When /^I run the program$/ do
  @app = Event::Reporter.new(output).run
end

ANY_COMMAND = "a_command"
When /^I enter any command$/ do
  output.clear
  @app.execute ANY_COMMAND
end

INVALID_COMMAND = "not a real command!!"
When /^I enter an invalid command$/ do
  @app.execute INVALID_COMMAND
end

When /^I issue the command "([^"]*)"$/ do |command|
  @app.execute command
end

When /^I issue the "([^"]*)" command for an invalid command$/ do |command|
  @app.execute "#{command} #{INVALID_COMMAND}"
end

Then /^I (should|should not) see "([^"]*)"$/ do |should_or_not, message|
  output.messages.send should_or_not.gsub(' ', '_'), include(message)
end

Then /^I should see the command prompt/ do
  output.messages.should include "Command: "
end

Then /^I should see a list of all available commands$/ do
  Event::Reporter::KNOWN_COMMANDS.keys.each do |command|
    output.messages.should include command
  end
end

Then /^issuing "([^"]*)" should return "([^"]*)"$/ do |command, expected_output|
  @app.execute command
  output.messages.should include expected_output
end

Then /^I should see the data table:$/ do |expected_table|
  output.messages.should include Event::Reporter::DATA_TABLE_HEADER
  expected_table.rows.each do |row|
    output.messages.should include row * "\t"
  end
end

Then /^I should see the ordered data table:$/ do |expected_table|
  output_text = output.messages
  output_text.should include Event::Reporter::DATA_TABLE_HEADER
  expected = expected_table.rows
  get_table(output_text, expected.size).should == delimited_table(expected)
end

def delimited_table rows
  rows.map{ |row| row * "\t" }
end

def find_start_of_data_table lines
  lines.rindex(Event::Reporter::DATA_TABLE_HEADER) + 1
end

def get_table lines, table_size
  start = find_start_of_data_table lines
  lines[start..(start + table_size - 1)]
end

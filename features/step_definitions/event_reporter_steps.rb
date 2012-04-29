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

Then /^I should see "([^"]*)"$/ do |message|
  output.messages.should include message
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
  start = output_text.rindex(Event::Reporter::DATA_TABLE_HEADER) + 1
  output_text[start..(start + expected_table.rows.size - 1)].should == expected_table.rows.
    map{ |row| row * "\t" }
end

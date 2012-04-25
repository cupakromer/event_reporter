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

Given /^I have not launched the program$/ do
  # Do nothing, we have no program to do anything with now.
end

Given /^I am at the command prompt$/ do
  @app = EventReporter::Reporter.new("event_attendees.csv", output)
  @app.run
  output.messages.last.should include "Command: "
end

When /^I run the program$/ do
  EventReporter::Reporter.new("event_attendees.csv", output).run
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

Then /^I should see "([^"]*)"$/ do |message|
  output.messages.should include message
end

Then /^I should see the command prompt/ do
  output.messages.should include "Command: "
end

Then /^I should see a list of all available commands$/ do
  EventReporter::Reporter::KNOWN_COMMANDS.keys.each do |command|
    output.messages.should include command
  end
end


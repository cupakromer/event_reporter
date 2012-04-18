class Output
  def messages
    @messages ||= []
  end

  def puts(message)
    messages << message
  end
end

def output
  @output ||= Output.new
end

Given /^I have not launched the program$/ do
  # Do nothing, we have no program to do anything with now.
end

When /^I run the program$/ do
  EventReporter::Reporter.new("event_attendees.csv", output).run
end

Then /^I should see "([^"]*)"$/ do |message|
  output.messages.should include message
end

Then /^I should see the command prompt$/ do
  output.messages.should include "Command: "
end

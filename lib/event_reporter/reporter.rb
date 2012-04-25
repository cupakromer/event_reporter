require 'csv'

module EventReporter
  class Reporter
    attr_reader :output

    def initialize data_file, output
      @output = output
      @known_commands = ["help", "load"]
    end

    def run
      output.puts "Welcome to Event Reporter!"
      output.puts "Command: "
    end

    def execute command
      command, *args = command.chomp.split

      if !known_commands.include? command
        output.puts "Sorry, I don't know that command"
        output.puts "Use the command 'help' to see a list of all valid commands"
      else
        case command
        when 'load'
          @file = CSV.open args[0], headers: true, header_converters: :symbol
          @attendees = []
          @file.each do |attendee|
            @attendees << attendee
          end
          output.puts "#{@attendees.size} attendees loaded"
        end
      end
      output.puts "Command: "
    end

    private
    attr_reader :known_commands
  end
end

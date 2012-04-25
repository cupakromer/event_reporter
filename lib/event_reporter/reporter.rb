require 'csv'

module EventReporter
  class Reporter
    attr_reader :output, :known_commands

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
          filename = args.empty? ? "event_attendees.csv" : args[0]
          output.puts filename
          @file = CSV.open filename, headers: true, header_converters: :symbol
          @attendees = []
          @file.each do |attendee|
            @attendees << attendee
          end
          output.puts "#{@attendees.size} attendees loaded"
        when 'help'
          known_commands.each do |command|
            output.puts command
          end
        end
      end
      output.puts "Command: "
    end
  end
end

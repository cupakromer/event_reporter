require 'csv'

module EventReporter
  class Reporter
    attr_reader :output, :known_commands

    def initialize data_file, output
      @output = output
      @known_commands = {
        "help" => "Output a listing of the available individual commands.",
        "load" => "Erase any loaded data and parse the specified file. If no filename is given, default to event_attendees.csv.",
        "queue count" => "Output how many records are in the current queue.",
        "queue clear" => "Empty the queue.",
        "queue print" => "Print out a tab-delimited data table with a header row.",
        "queue print by" => "Print the data table sorted by the specified attribute.",
        "queue save to" => "Export the current queue to the specified filename as a CSV.",
        "find" => "Load the queue with all records matching the criteria for the given attribute."
      }
    end

    def run
      output.puts "Welcome to Event Reporter!"
      output.puts "Command: "
    end

    def execute command
      command, *args = command.chomp.split

      if !known_commands.keys.include? command
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
          if args.empty?
            known_commands.keys.each do |command|
              output.puts command
            end
          else
            output.puts known_commands[args * " "]
          end
        end
      end
      output.puts "Command: "
    end
  end
end

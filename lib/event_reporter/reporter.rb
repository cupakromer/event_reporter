require 'csv'

module EventReporter
  class Reporter
    attr_reader :output, :known_commands

    KNOWN_COMMANDS = {
      "help" => "Output a listing of the available individual commands.",
      "load" => "Erase any loaded data and parse the specified file. If no filename is given, default to event_attendees.csv.",
      "queue count" => "Output how many records are in the current queue.",
      "queue clear" => "Empty the queue.",
      "queue print" => "Print out a tab-delimited data table with a header row.",
      "queue print by" => "Print the data table sorted by the specified attribute.",
      "queue save to" => "Export the current queue to the specified filename as a CSV.",
      "find" => "Load the queue with all records matching the criteria for the given attribute."
    }

    def initialize output
      @output = output
    end

    def run
      output.puts "Welcome to Event Reporter!"
      output.puts "Command: "
    end

    def execute command
      command, *args = command.chomp.split

      case command
      when 'load'
        filename = args.empty? ? "event_attendees.csv" : args[0]
        load_attendees_from filename
      when 'help'
        help args
      else
        output.puts "Sorry, I don't know that command"
        output.puts "Use the command 'help' to see a list of all valid commands"
      end
      output.puts "Command: "
    end

    private
    def load_attendees_from filename
      file = CSV.open filename, headers: true, header_converters: :symbol
      @attendees = []
      file.each do |attendee|
        @attendees << attendee
      end
      output.puts "#{@attendees.size} attendees loaded"
    end

    def help args
      if args.empty?
        KNOWN_COMMANDS.keys.each do |command|
          output.puts command
        end
      else
        output.puts command_description args * " "
      end
    end

    def command_description command
      KNOWN_COMMANDS[command]
    end
  end

end

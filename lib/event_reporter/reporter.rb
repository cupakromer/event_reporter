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
      when 'queue'
        command, *args = *args
        case command
        when 'count'
          output.puts "#{queue_count} attendees in queue"
        when 'clear'
          queue_clear
        else
          output_help_messages
        end
      else
        output_help_messages
      end
      output.puts "Command: "
    end

    attr_accessor :attendees

    def load_attendees_from filename
      file = CSV.open filename, headers: true, header_converters: :symbol
      @attendees = []
      file.each do |attendee|
        @attendees << clean_data(attendee)
      end
      output.puts "#{@attendees.size} attendees loaded"
    end

    def clean_data attendee_record
      attendee_record[:homephone] = clean_number attendee_record[:homephone]
    end

    INVALID_PHONE_NUMBER_CHARACTERS = /\D/
    VALID_PHONE_NUMBER_LENGTH = 10
    INVALID_PHONE_NUMBER = "0000000000"
    US_PHONE_CODE = "1"

    def clean_number original
      original ||= ""
      original = original.gsub INVALID_PHONE_NUMBER_CHARACTERS, ''

      if original.length == VALID_PHONE_NUMBER_LENGTH
        original
      elsif number_has_us_code? original
        original[1..-1]
      else
        INVALID_PHONE_NUMBER
      end
    end

    def number_has_us_code? number
      number.length == (VALID_PHONE_NUMBER_LENGTH + 1) &&
      number.start_with?(US_PHONE_CODE)
    end

    def output_help_messages
      output.puts "Sorry, I don't know that command"
      output.puts "Use the command 'help' to see a list of all valid commands"
    end

    def help args
      command = args * " "

      if command.empty?
        KNOWN_COMMANDS.keys.each do |command|
          output.puts command
        end
      elsif KNOWN_COMMANDS.include? command
        output.puts command_description args * " "
      else
        output_help_messages
      end
    end

    def queue_count
      attendees.size
    end

    def queue_clear
      attendees.clear
      output.puts "Attendee queue is empty"
    end

    def command_description command
      KNOWN_COMMANDS[command]
    end
  end

end

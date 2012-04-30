require 'csv'
require 'event/data_cleaner'

class String
  def titlecase ; split(/ /).map!{|w| w.capitalize}.join(' ') ; end
end

module Event
  class Reporter
    attr_reader :output, :known_commands
    attr_accessor :attendees

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
      @cleaner = DataCleaner
    end

    def run
      output.puts "Welcome to Event Reporter!"
      output.puts "Command: "
    end

    def execute command
      case command.chomp
      when /^help(?: )?(.*)$/
        help $1
      when /^load(?: )?(.*)$/
        filename = $1.empty? ? "event_attendees.csv" : $1
        load_attendees_from filename
        output.puts "#{attendees.size} attendees loaded"
      when /^queue count$/
        output.puts "#{queue_count} attendees in queue"
      when /^queue clear$/
        queue_clear
      when /^queue print$/
        print_delimited attendees
      when /^queue print by (.*)$/
        print_delimited sort_queue_by $1
      when /^find (\w+) (.*)$/
        load_attendees_from @last_loaded_file
        filter_attendees_by! $1, $2
        output.puts "#{attendees.size} attendees loaded"
      else
        output_help_messages
      end

      output.puts "Command: "
    end

    def load_attendees_from filename
      file = CSV.open filename, headers: true, header_converters: :symbol
      @last_loaded_file = filename
      @attendees = []
      file.each do |attendee|
        @attendees << clean_data(attendee)
      end
      @attributes = file.headers
    end

    def filter_attendees_by! attribute, criteria
      attendees.select!{ |attendee|
        attendee[attribute.to_sym].downcase == criteria.downcase
      }
    end

    def clean_data record
      record[:homephone] = @cleaner.clean_phone_number record[:homephone]
      record[:zipcode] = @cleaner.clean_zipcode record[:zipcode]
      record[:email].downcase! if record[:email]

      [:first_name, :last_name].each{ |a| record[a] &&= record[a].titlecase }

      record
    end

    def output_help_messages
      output.puts "Sorry, I don't know that command"
      output.puts "Use the command 'help' to see a list of all valid commands"
    end

    def output_all_command_names
      KNOWN_COMMANDS.keys.each do |command|
        output.puts command
      end
    end

    def help command
      if command.empty?
        output_all_command_names
      elsif KNOWN_COMMANDS.include? command
        output.puts command_description command
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

    def sort_queue_by attribute
      attribute &&= attribute.to_sym
      if !@attributes.include? attribute
        output.puts "Unknown attribute '#{attribute}'"
        return nil
      end
      attendees.sort_by{ |attendee| attendee[attribute] }
    end

    DATA_TABLE_HEADER =
      "LAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE"

    def print_delimited data
      return unless data
      output.puts DATA_TABLE_HEADER
      data.each do |a|
        output.puts "#{a[:last_name]}\t#{a[:first_name]}\t" \
                    "#{a[:email_address]}\t#{a[:zipcode]}\t#{a[:city]}\t" \
                    "#{a[:state]}\t#{a[:street]}\t#{a[:homephone]}"
      end
    end

    def command_description command
      KNOWN_COMMANDS[command]
    end
  end

end

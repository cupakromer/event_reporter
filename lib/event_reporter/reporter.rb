
module EventReporter
  class Reporter
    attr_reader :output

    def initialize data_file, output
      @output = output
      @known_commands = ["help"]
    end

    def run
      output.puts "Welcome to Event Reporter!"
      output.puts "Command: "
    end

    def execute command
      if !known_commands.include? command
        output.puts "Sorry, I don't know that command"
      end
      output.puts "Command: "
    end

    private
    attr_reader :known_commands
  end
end

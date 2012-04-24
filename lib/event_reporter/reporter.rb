
module EventReporter
  class Reporter
    attr_reader :output

    def initialize data_file, output
      @output = output
    end

    def run
      output.puts "Welcome to Event Reporter!"
      output.puts "Command: "
    end

    def execute command
      output.puts "Command: "
    end
  end
end

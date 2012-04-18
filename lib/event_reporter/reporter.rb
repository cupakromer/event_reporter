
module EventReporter
  class Reporter
    def initialize data_file, output
      @output = output
    end

    def output; @output; end

    def run
      output.puts "Welcome to Event Reporter!"
      output.puts "Command: "
    end
  end
end

require 'spec_helper'

module EventReporter
  describe Reporter do
    describe "#clean_phone_number" do
      {
        "1234567890"     => "1234567890",
        "(123) 456-7890" => "1234567890",
        "1.234 567#890"  => "1234567890",
        "12345678900"    => "2345678900",
        "23456789012"    => "0000000000",
        nil              => "0000000000",
        "you no can haz" => "0000000000",
        "12345"          => "0000000000",
      }.each do |phone_number, cleaned_number|
        it "converts #{phone_number} to #{cleaned_number}" do
          output = double('output')
          reporter = Reporter.new output
          reporter.clean_phone_number(phone_number).should == cleaned_number
        end
      end
    end
  end
end

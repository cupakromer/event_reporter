require 'event/data_cleaner'

module Event
  describe DataCleaner do
    describe ".clean_phone_number" do
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
          DataCleaner.clean_phone_number(phone_number).should == cleaned_number
        end
      end
    end

    describe ".clean_zipcode" do
      {
        "12345" => "12345",
        "1234"  => "01234",
        "123"   => "00123",
        "12"    => "00012",
        "1"     => "00001",
        nil     => "00000",
        "abc"   => "00000",
        "01.12" => "00112",
      }.each do |zipcode, cleanded_zipcode|
        it "converts #{zipcode} to #{cleanded_zipcode}" do
          DataCleaner.clean_zipcode(zipcode).should == cleanded_zipcode
        end
      end
    end
  end
end

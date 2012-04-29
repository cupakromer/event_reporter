module Event
  module DataCleaner
    INVALID_PHONE_NUMBER_CHARS = INVALID_ZIPCODE_CHARS = /\D/
    VALID_PHONE_NUMBER_LENGTH = 10
    INVALID_PHONE_NUMBER = "0000000000"
    US_PHONE_CODE = "1"

    INVALID_ZIPCODE = "00000"
    VALID_ZIPCODE_LENGTH = 5
    ZIPCODE_PAD = "0"

    def self.clean_phone_number original
      numbers = scrub_invalid_chars original, INVALID_PHONE_NUMBER_CHARS, ""

      if numbers.length == VALID_PHONE_NUMBER_LENGTH
        numbers
      elsif phone_has_us_code? numbers
        numbers[1..-1]
      else
        INVALID_PHONE_NUMBER
      end
    end

    def self.clean_zipcode dirty
      zip = scrub_invalid_chars dirty, INVALID_ZIPCODE_CHARS, INVALID_ZIPCODE

      zip.length < VALID_ZIPCODE_LENGTH ? pad_zipcode(zip) : zip
    end

    private
    def self.scrub_invalid_chars dirty, matcher, default_val
      dirty ? dirty.gsub(matcher, '') : default_val
    end

    def self.phone_has_us_code? number
      number.length == (VALID_PHONE_NUMBER_LENGTH + 1) &&
      number.start_with?(US_PHONE_CODE)
    end

    def self.pad_zipcode original
      ZIPCODE_PAD * (VALID_ZIPCODE_LENGTH - original.length) + original
    end

  end
end

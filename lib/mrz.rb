require "mrz/version"
require "mrz/invalid_format_error"
require "mrz/check_digit"
require "mrz/result"
require "mrz/base_parser"
require "mrz/td1_parser"
require "mrz/td2_parser"
require "mrz/td3_parser"

module MRZ
  def self.parse(mrz_code)
    case determine_type(mrz_code)
    when :td1
      TD1Parser.new(mrz_code).parse
    when :td2
      TD2Parser.new(mrz_code).parse
    when :td3
      TD3Parser.new(mrz_code).parse
    end
  end

  private

    def self.determine_type(code)
      if code.size == 3
        :td1
      elsif code.size == 2 && code.first.size == 36
        :td2
      elsif code.size == 2 && code.first.size == 44
        :td3
      else
        raise MRZ::InvalidFormatError, "invalid or unsupported mrz code given"
      end
    end
end

module MRZ
  class TD3Parser < BaseParser
    FORMAT_ONE = /\A(.{2})(.{3})([^<]+)<(.*)\z/
    FORMAT_TWO = /\A(.{9})(\d)(.{3})(\d{6})(\d)(.)(\d{6})(.)(.{14})(.)(\d)/

    def initialize(code_ary)
      @code = code_ary
      @one = code_ary[0]
      @two = code_ary[1]
    end

    def parse
      if @code.size != 2
        raise MRZ::InvalidFormatError, "td3 requires two mrz lines"
      end

      line_one_matches = FORMAT_ONE.match(@one)
      line_two_matches = FORMAT_TWO.match(@two)

      if @one.length != 44 || line_one_matches.nil?
        raise MRZ::InvalidFormatError, "td3 line one does not match the required format"
      end

      if line_two_matches.nil?
        raise MRZ::InvalidFormatError, "td3 line two does not match the required format"
      end

      MRZ::Result.new(
        birth_date: line_two_matches[4],
        birth_date_check_digit: line_two_matches[5],
        composite_check_digit: line_two_matches[11],
        document_code: special_char_to_empty_space(line_one_matches[1]),
        document_number: special_char_to_empty_space(line_two_matches[1]),
        document_number_check_digit: line_two_matches[2],
        expiration_date: line_two_matches[7],
        expiration_date_check_digit: line_two_matches[8],
        first_name: special_char_to_white_space(line_one_matches[4]).strip,
        issuing_state: special_char_to_empty_space(line_one_matches[2]),
        last_name: line_one_matches[3],
        nationality: special_char_to_empty_space(line_two_matches[3]),
        optional1: special_char_to_empty_space(line_two_matches[9]),
        optional2: special_char_to_empty_space(line_two_matches[10]),
        sex: special_char_to_empty_space(line_two_matches[6]),
        type: :td3,
      )
    end
  end
end

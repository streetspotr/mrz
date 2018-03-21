class BaseParser
  SPECIAL_CHAR = "<"
  WHITESPACE = " "
  EMPTY_SPACE = ""

  protected

    def special_char_to_empty_space(str)
      str.gsub(SPECIAL_CHAR, EMPTY_SPACE)
    end

    def special_char_to_white_space(str)
      str.gsub(SPECIAL_CHAR, WHITESPACE)
    end
end

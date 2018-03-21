module MRZ
  class TD1Parser
    def initialize(code_ary)
      if code_ary.size != 3
        raise MRZ::InvalidFormatError, "TD1 requires three rows"
      end
    end

    def parse
      MRZ::Result.new(
        birth_date: "",
        expiration_date: "",
        birth_date_check_digit: "",
        composite_check_digit: "",
        document_code: "",
        document_number: "",
        document_number_check_digit: "",
        expiration_date_check_digit: "",
        first_name: "",
        issuing_state: "",
        last_name: "",
        nationality: "",
        optional1: "",
        optional2: "",
        sex: ""
      )
    end
  end
end

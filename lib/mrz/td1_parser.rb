module MRZ
  class TD1Parser
    def initialize(code_ary)
      if code_ary.size != 3
        raise MRZ::InvalidFormatError, "TD1 requires three rows"
      end
    end

    def parse
      MRZ::Result.new
    end
  end
end

require "date"

module MRZ
  class Result
    attr_reader :birth_date_check_digit, :composite_check_digit,
                :document_code, :document_number, :document_number_check_digit,
                :expiration_date_check_digit, :first_name, :issuing_state,
                :last_name, :nationality, :optional1, :optional2

    def initialize(opts={})
      @birth_date                  = opts.fetch(:birth_date)
      @birth_date_check_digit      = opts.fetch(:birth_date_check_digit)
      @composite_check_digit       = opts.fetch(:composite_check_digit)
      @document_code               = opts.fetch(:document_code)
      @document_number             = opts.fetch(:document_number)
      @document_number_check_digit = opts.fetch(:document_number_check_digit)
      @expiration_date             = opts.fetch(:expiration_date)
      @expiration_date_check_digit = opts.fetch(:expiration_date_check_digit)
      @first_name                  = opts.fetch(:first_name)
      @issuing_state               = opts.fetch(:issuing_state)
      @last_name                   = opts.fetch(:last_name)
      @nationality                 = opts.fetch(:nationality)
      @optional1                   = opts.fetch(:optional1)
      @optional2                   = opts.fetch(:optional2)
      @sex                         = opts.fetch(:sex)
      @type                        = opts.fetch(:type)
    end

    def birth_date
      @_birth_date ||= begin
        year = @birth_date[0..1].to_i
        month = @birth_date[2..3].to_i
        day = @birth_date[4..5].to_i

        Date.new(add_correct_century(year), month, day)
      end
    end

    def expiration_date
      @_expiration_date ||= Date.strptime(@expiration_date, "%y%m%d")
    end

    def sex
      @_sex ||= @sex == "" ? "nonspecified" : @sex
    end

    def valid?
      @_valid ||= begin
        valid_birth_date? && valid_expiration_date? && valid_document_number? && valid_composite_digit?
      end
    end

    def valid_birth_date?
      @_valid_birth_date ||= MRZ::CheckDigit.calculate(@birth_date).to_s == @birth_date_check_digit
    end

    def valid_expiration_date?
      @_valid_expiration_date ||= MRZ::CheckDigit.calculate(@expiration_date).to_s == @expiration_date_check_digit
    end

    def valid_document_number?
      @_valid_document_number ||= MRZ::CheckDigit.calculate(@document_number).to_s == @document_number_check_digit
    end

    private

      def add_correct_century(year)
        if (Date.today.year - (1900 + year)) >= 100
          2000 + year
        else
          1900 + year
        end
      end

      def valid_composite_digit?
        if @type == :td1
          MRZ::CheckDigit.calculate(
            @document_number + @document_number_check_digit +
            @optional1 + @birth_date + @birth_date_check_digit +
            @expiration_date + @expiration_date_check_digit +
            @optional2
          ).to_s == @composite_check_digit
        elsif [:td2, :td3].include?(@type)
          MRZ::CheckDigit.calculate(
            @document_number + @document_number_check_digit +
            @birth_date + @birth_date_check_digit +
            @expiration_date + @expiration_date_check_digit +
            @optional1 + @optional2
          ).to_s == @composite_check_digit
        else
          raise InvalidFormatError, "Unknown format type"
        end
      end
  end
end

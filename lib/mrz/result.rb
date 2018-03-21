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

    private

      def add_correct_century(year)
        if (Date.today.year - (1900 + year)) >= 100
          2000 + year
        else
          1900 + year
        end
      end
  end
end

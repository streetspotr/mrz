RSpec.describe MRZ::TD3Parser do
  let(:mrz_array) do [
    [
      "P<D<<ADENAUER<<KONRAD<HERMANN<JOSEPH<<<<<<<<",
      "1234567897D<<7601059M6704115<<<<<<<<<<<<<<<2"
    ],
    [
      "P<UTOERIKSSON<<ANNA<MARIA<<<<<<<<<<<<<<<<<<<",
      "1234567897D<<7601059M6704115<<<<<<<<<<<<<<<2"
    ],
    [
      "P<UTOHENG<<DEBORAH<MING<LO<<<<<<<<<<<<<<<<<<",
      "1234567897D<<7601059M6704115<<<<<<<<<<<<<<<2"
    ],
    [
      "P<UTOOCONNOR<<ENYA<SIOBHAN<<<<<<<<<<<<<<<<<<",
      "1234567897D<<7601059M6704115<<<<<<<<<<<<<<<2"
    ],
    [
      "P<UTOVAN<DER<MUELLEN<<MARTIN<<<<<<<<<<<<<<<<",
      "1234567897D<<7601059M6704115<<<<<<<<<<<<<<<2"
    ],
    [
      "P<UTOARKFREITH<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<",
      "1234567897D<<7601059M6704115<<<<<<<<<<<<<<<2"
    ],
    [
      "P<UTOSMITH<JONES<<SUSIE<MARGARET<<<<<<<<<<<<",
      "1234567897D<<7601059M6704115<<<<<<<<<<<<<<<2"
    ],
    [
      "P<UTOAL<BASRI<<HUDA<MUHAMMAD<JAWAD<<<<<<<<<<",
      "1234567897D<<7601059M6704115<<<<<<<<<<<<<<<2"
    ],
    [
      "P<UTOVILARCHAO<FERNANDEZ<<JOSE<RAMON<<<<<<<<",
      "1234567897D<<7601059M6704115<<<<<<<<<<<<<<<2"
    ],
  ]
  end

  describe "#initialize" do
    it "should take an array of strings" do
      MRZ::TD3Parser.new(["one", "two"])
    end
  end

  describe "#parse" do
    it "should accept all valid formats" do
      mrz_array.each do |ary |
        MRZ::TD3Parser.new(ary).parse
      end
    end

    it "should raise an error if array contains more than two strings" do
      expect { MRZ::TD3Parser.new(["one", "two", "three"]).parse }.to raise_error(MRZ::InvalidFormatError)
    end

    it "should raise an error if array contains less than two strings" do
      expect { MRZ::TD3Parser.new(["one", ]).parse }.to raise_error(MRZ::InvalidFormatError)
    end

    it "should return a correct MRZ::Result instance" do
      res = MRZ::TD3Parser.new(mrz_array[0]).parse

      expect(res.birth_date).to                  eq(Date.new(1976, 1, 5))
      expect(res.birth_date_check_digit).to      eq("9")
      expect(res.composite_check_digit).to       eq("2")
      expect(res.document_code).to               eq("P")
      expect(res.document_number).to             eq("123456789")
      expect(res.document_number_check_digit).to eq("7")
      expect(res.expiration_date).to             eq(Date.new(2067, 4, 11))
      expect(res.expiration_date_check_digit).to eq("5")
      expect(res.first_name).to                  eq("KONRAD HERMANN JOSEPH")
      expect(res.issuing_state).to               eq("D")
      expect(res.last_name).to                   eq("ADENAUER")
      expect(res.nationality).to                 eq("D")
      expect(res.optional1).to                   eq("")
      expect(res.optional2).to                   eq("")
      expect(res.sex).to                         eq("M")
      expect(res.valid?).to                      eq(true)
    end

    it "should raise an error if line one does not match the required format" do
      ary = [
        mrz_array[0][0][0..-2],
        mrz_array[0][1]
      ]

      expect { MRZ::TD3Parser.new(ary).parse }.to raise_error(MRZ::InvalidFormatError)
    end

    it "should raise an error if line two does not match the required format" do
      ary = [
        mrz_array[0][0],
        mrz_array[0][1][0..-2]
      ]

      expect { MRZ::TD3Parser.new(ary).parse }.to raise_error(MRZ::InvalidFormatError)
    end
  end
end

RSpec.describe MRZ::TD3Parser do
  let(:mrz_array) do
    [
      "P<D<<ADENAUER<<KONRAD<HERMANN<JOSEPH<<<<<<<<",
      "1234567897D<<7601059M6704115<<<<<<<<<<<<<<<2"
    ]
  end

  context "#initialize" do
    it "should take an array of strings" do
      MRZ::TD3Parser.new(["one", "two"])
    end
  end

  context "#parse" do
    it "should raise an error if array contains more than two strings" do
      expect { MRZ::TD3Parser.new(mrz_array.concat(["hello!!"])).parse }.to raise_error(MRZ::InvalidFormatError)
    end

    it "should raise an error if array contains less than two strings" do
      expect { MRZ::TD3Parser.new([ mrz_array[0] ]).parse }.to raise_error(MRZ::InvalidFormatError)
    end

    it "should return a correct MRZ::Result instance" do
      res = MRZ::TD3Parser.new(mrz_array).parse

      expect(res.birth_date).to eq(Date.new(1976, 1, 5))
      expect(res.birth_date_check_digit).to eq("9")
      expect(res.composite_check_digit).to eq("2")
      expect(res.document_code).to eq("P")
      expect(res.document_number).to eq("123456789")
      expect(res.document_number_check_digit).to eq("7")
      expect(res.expiration_date).to eq(Date.new(2067, 4, 11))
      expect(res.expiration_date_check_digit).to eq("5")
      expect(res.first_name).to eq("KONRAD HERMANN JOSEPH")
      expect(res.issuing_state).to eq("D")
      expect(res.last_name).to eq("ADENAUER")
      expect(res.nationality).to eq("D")
      expect(res.optional1).to eq("")
      expect(res.optional2).to eq("")
      expect(res.sex).to eq("M")
    end

    it "should raise an error if line one does not match the required format" do
      ary = [
        mrz_array[0][0..-2],
        mrz_array[1]
      ]

      expect { MRZ::TD3Parser.new(ary).parse }.to raise_error(MRZ::InvalidFormatError)
    end

    it "should raise an error if line two does not match the required format" do
      ary = [
        mrz_array[0],
        mrz_array[1][0..-2]
      ]

      expect { MRZ::TD3Parser.new(ary).parse }.to raise_error(MRZ::InvalidFormatError)
    end
  end
end

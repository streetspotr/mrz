RSpec.describe MRZ::TD2Parser do
  let(:mrz_array) do
    [
      "I<UTOERIKSSON<<ANNA<MARIA<<<<<<<<<<<",
      "D231458907UTO7408122F1204159<<<<<<<6"
    ]
  end

  describe "#initialize" do
    it "should take an array of strings" do
      MRZ::TD2Parser.new(["one", "two"])
    end
  end

  describe "#parse" do
    it "should raise an error if array contains more than two strings" do
      expect { MRZ::TD2Parser.new(mrz_array.concat(["hello!!"])).parse }.to raise_error(MRZ::InvalidFormatError)
    end

    it "should raise an error if array contains less than two strings" do
      expect { MRZ::TD2Parser.new([ mrz_array[0] ]).parse }.to raise_error(MRZ::InvalidFormatError)
    end

    it "should return a correct MRZ::Result instance" do
      res = MRZ::TD2Parser.new(mrz_array).parse

      expect(res.birth_date).to eq(Date.new(1974, 8, 12))
      expect(res.birth_date_check_digit).to eq("2")
      expect(res.composite_check_digit).to eq("6")
      expect(res.document_code).to eq("I")
      expect(res.document_number).to eq("D23145890")
      expect(res.document_number_check_digit).to eq("7")
      expect(res.expiration_date).to eq(Date.new(2012, 4, 15))
      expect(res.expiration_date_check_digit).to eq("9")
      expect(res.first_name).to eq("ANNA MARIA")
      expect(res.issuing_state).to eq("UTO")
      expect(res.last_name).to eq("ERIKSSON")
      expect(res.nationality).to eq("UTO")
      expect(res.optional1).to eq("")
      expect(res.optional2).to eq("")
      expect(res.sex).to eq("F")
    end

    it "should raise an error if line one does not match the required format" do
      ary = [
        mrz_array[0][0..-2],
        mrz_array[1]
      ]

      expect { MRZ::TD2Parser.new(ary).parse }.to raise_error(MRZ::InvalidFormatError)
    end

    it "should raise an error if line two does not match the required format" do
      ary = [
        mrz_array[0],
        mrz_array[1][0..-2]
      ]

      expect { MRZ::TD2Parser.new(ary).parse }.to raise_error(MRZ::InvalidFormatError)
    end
  end
end

RSpec.describe MRZ::TD1Parser do
  let(:mrz_array) do
    [
      "IDD<<T220001293<<<<<<<<<<<<<<<",
      "6408125<2010315D<<<<<<<<<<<<<4",
      "MUSTERMANN<<ERIKA<PAULA<ANNA<<"
    ]
  end

  context "#initialize" do
    it "should take an array of strings" do
      MRZ::TD1Parser.new(["one", "two", "three"])
    end
  end

  context "#parse" do
    it "should raise an error if array contains more than three strings" do
      expect { MRZ::TD1Parser.new(mrz_array.concat(["hello!!"])).parse }.to raise_error(MRZ::InvalidFormatError)
    end

    it "should raise an error if array contains less than three strings" do
      expect { MRZ::TD1Parser.new(mrz_array[0..1]).parse }.to raise_error(MRZ::InvalidFormatError)
    end

    it "should return a correct MRZ::Result instance" do
      res = MRZ::TD1Parser.new(mrz_array).parse

      expect(res.birth_date).to                  eq(Date.new(1964, 8, 12))
      expect(res.birth_date_check_digit).to      eq("5")
      expect(res.composite_check_digit).to       eq("4")
      expect(res.document_code).to               eq("ID")
      expect(res.document_number).to             eq("T22000129")
      expect(res.document_number_check_digit).to eq("3")
      expect(res.expiration_date).to             eq(Date.new(2020, 10, 31))
      expect(res.expiration_date_check_digit).to eq("5")
      expect(res.first_name).to                  eq("ERIKA PAULA ANNA")
      expect(res.issuing_state).to               eq("D")
      expect(res.last_name).to                   eq("MUSTERMANN")
      expect(res.nationality).to                 eq("D")
      expect(res.optional1).to                   eq("")
      expect(res.optional2).to                   eq("")
      expect(res.sex).to                         eq("nonspecified")
    end

    it "should raise an error if line one does not match the required format" do
      ary = [
        mrz_array[0][0..-2],
        mrz_array[1],
        mrz_array[2]
      ]

      expect { MRZ::TD1Parser.new(ary).parse }.to raise_error(MRZ::InvalidFormatError)
    end

    it "should raise an error if line two does not match the required format" do
      ary = [
        mrz_array[0],
        mrz_array[1][0..-2],
        mrz_array[2]
      ]

      expect { MRZ::TD1Parser.new(ary).parse }.to raise_error(MRZ::InvalidFormatError)
    end

    it "should raise an error if line three does not match the required format" do
      ary = [
        mrz_array[0],
        mrz_array[1],
        mrz_array[2][0..-2]
      ]

      expect { MRZ::TD1Parser.new(ary).parse }.to raise_error(MRZ::InvalidFormatError)
    end
  end
end

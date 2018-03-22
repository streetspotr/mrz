RSpec.describe MRZ do
  it "has a version number" do
    expect(MRZ::VERSION).not_to be nil
  end

  describe "#parse" do
    it "should be able to correctly parse a td1 ID card" do
      id_card = [
        "IDD<<T220001293<<<<<<<<<<<<<<<",
        "6408125<2010315D<<<<<<<<<<<<<4",
        "MUSTERMANN<<ERIKA<PAULA<ANNA<<"
      ]

      expect(MRZ.parse(id_card).valid?).to eq(true)
    end

    it "should be able to correctly parse a td2 ID card" do
      id_card = [
        "I<UTOERIKSSON<<ANNA<MARIA<<<<<<<<<<<",
        "D231458907UTO7408122F1204159<<<<<<<6"
      ]

      expect(MRZ.parse(id_card).valid?).to eq(true)
    end

    it "should be able to correctly parse a td3 passport" do
      passport = [
        "P<D<<ADENAUER<<KONRAD<HERMANN<JOSEPH<<<<<<<<",
        "1234567897D<<7601059M6704115<<<<<<<<<<<<<<<2"
      ]

      expect(MRZ.parse(passport).valid?).to eq(true)
    end

    it "should raise an error if it could not determine type" do
      expect { MRZ.parse(["hi"]) }.to raise_error(MRZ::InvalidFormatError)
    end
  end
end

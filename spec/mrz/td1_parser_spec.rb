RSpec.describe MRZ::TD1Parser do
  context "#initialize" do
    it "should take an array of strings" do
      MRZ::TD1Parser.new(["one", "two", "three"])
    end

    it "should raise an error if array contains more than three strings" do
      expect { MRZ::TD1Parser.new(["one", "two", "three", "four"]) }.to raise_error(MRZ::InvalidFormatError)
    end

    it "should raise an error if array contains less than three strings" do
      expect { MRZ::TD1Parser.new(["one", "two"]) }.to raise_error(MRZ::InvalidFormatError)
    end
  end

  context "#parse" do
    it "should return a MRZ::Result instance" do
      res = MRZ::TD1Parser.new(["one", "two", "three"]).parse
      expect(res.is_a?(MRZ::Result)).to be(true)
    end
  end
end

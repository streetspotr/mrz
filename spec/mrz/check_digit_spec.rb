RSpec.describe MRZ::CheckDigit do
  describe "#calculate" do
    it "should return the correct value #1" do
      value = MRZ::CheckDigit.calculate("123456789")
      expect(value).to eq(7)
    end

    it "should return the correct value #2" do
      value = MRZ::CheckDigit.calculate("120415")
      expect(value).to eq(9)
    end
  end
end

require "date"

RSpec.describe MRZ::Result do
  let(:result) do
    MRZ::Result.new(
      birth_date: "640812",
      birth_date_check_digit: "5",
      composite_check_digit: "4",
      document_code: "ID",
      document_number: "T22000129",
      document_number_check_digit: "3",
      expiration_date: "201031",
      expiration_date_check_digit: "5",
      first_name: "ERIKA",
      issuing_state: "D",
      last_name: "MUSTERMANN",
      nationality: "D",
      optional1: "",
      optional2: "",
      sex: "",
      type: :td1
    )
  end

  describe "#birth_date" do
    it "should return birth_date as Date" do
      expected = Date.new(1964, 8, 12)

      expect(result.birth_date).to eq(expected)
    end

    it "should return date in the 2000s if year would be 100 years away" do
      result.instance_variable_set(:@birth_date, "180812")

      expected = Date.new(2018, 8, 12)

      expect(result.birth_date).to eq(expected)
    end
  end

  describe "#birth_date_check_digit" do
    it "should return the correct value" do
      expect(result.birth_date_check_digit).to eq("5")
    end
  end

  describe "#composite_check_digit" do
    it "should return the correct value" do
      expect(result.composite_check_digit).to eq("4")
    end
  end

  describe "#document_code" do
    it "should return the correct value" do
      expect(result.document_code).to eq("ID")
    end
  end

  describe "#document_number" do
    it "should return the correct value" do
      expect(result.document_number).to eq("T22000129")
    end
  end

  describe "#document_number_check_digit" do
    it "should return the correct value" do
      expect(result.document_number_check_digit).to eq("3")
    end
  end

  describe "#expiration_date" do
    it "should return expiration_date as Date" do
      expected = Date.new(2020, 10, 31)

      expect(result.expiration_date).to eq(expected)
    end
  end

  describe "#expiration_date_check_digit" do
    it "should return the correct value" do
      expect(result.expiration_date_check_digit).to eq("5")
    end
  end

  describe "#first_name" do
    it "should return the correct value" do
      expect(result.first_name).to eq("ERIKA")
    end
  end

  describe "#issuing_state" do
    it "should return the correct value" do
      expect(result.issuing_state).to eq("D")
    end
  end

  describe "#last_name" do
    it "should return the correct value" do
      expect(result.last_name).to eq("MUSTERMANN")
    end
  end

  describe "#nationality" do
    it "should return the correct value" do
      expect(result.nationality).to eq("D")
    end
  end

  describe "#optional1" do
    it "should return the correct value" do
      expect(result.optional1).to eq("")
    end
  end

  describe "#optional2" do
    it "should return the correct value" do
      expect(result.optional2).to eq("")
    end
  end

  describe "#sex" do
    it "should return nonspecified if empty" do
      expect(result.sex).to eq("nonspecified")
    end

    it "should return correct value if not empty" do
      result.instance_variable_set(:@sex, "m")
      expect(result.sex).to eq("m")
    end
  end

  describe "#valid?" do
    it "should return false if birth date check digit does not match" do
      result.instance_variable_set(:@birth_date_check_digit, "1")
      expect(result.valid?).to eq(false)
    end

    it "should return false if document number check digit does not match" do
      result.instance_variable_set(:@document_number_check_digit, "1")
      expect(result.valid?).to eq(false)
    end

    it "should return false if expiration date check digit does not match" do
      result.instance_variable_set(:@expiration_date_check_digit, "1")
      expect(result.valid?).to eq(false)
    end

    context "with type = :td1" do
      it "should return true if all check digits match" do
        expect(result.valid?).to eq(true)
      end

      it "should return false if composite check digit does not match" do
        result.instance_variable_set(:@composite_check_digit, "1")
        expect(result.valid?).to eq(false)
      end
    end

    context "with type = :td2" do
      before(:each) do
        result.instance_variable_set(:@type, :td2)
      end

      it "should return true if all check digits match" do
        expect(result.valid?).to eq(true)
      end

      it "should return false if composite check digit does not match" do
        result.instance_variable_set(:@composite_check_digit, "1")
        expect(result.valid?).to eq(false)
      end
    end

    context "with type = :td3" do
      before(:each) do
        result.instance_variable_set(:@type, :td3)
      end

      it "should return true if all check digits match" do
        expect(result.valid?).to eq(true)
      end

      it "should return false if composite check digit does not match" do
        result.instance_variable_set(:@composite_check_digit, "1")
        expect(result.valid?).to eq(false)
      end
    end
  end

  describe "#valid_birth_date?" do
    it "should return true if birth_date checksum matches" do
      expect(result.valid_birth_date?).to eq(true)
    end

    it "should return false if birth_date checksum does not match" do
      result.instance_variable_set(:@birth_date_check_digit, "1")
      expect(result.valid_birth_date?).to eq(false)
    end
  end

  describe "#valid_expiration_date?" do
    it "should return true if expiration_date checksum matches" do
      expect(result.valid_expiration_date?).to eq(true)
    end

    it "should return false if expiration_date checksum does not match" do
      result.instance_variable_set(:@expiration_date_check_digit, "1")
      expect(result.valid_expiration_date?).to eq(false)
    end
  end

  describe "#valid_document_number?" do
    it "should return true if document_number checksum matches" do
      expect(result.valid_document_number?).to eq(true)
    end

    it "should return false if document_number checksum does not match" do
      result.instance_variable_set(:@document_number_check_digit, "1")
      expect(result.valid_document_number?).to eq(false)
    end
  end
end

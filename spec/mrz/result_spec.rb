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
      sex: ""
    )
  end

  context "#birth_date" do
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

  context "#birth_date_check_digit" do
    it "should return the correct value" do
      expect(result.birth_date_check_digit).to eq("5")
    end
  end

  context "#composite_check_digit" do
    it "should return the correct value" do
      expect(result.composite_check_digit).to eq("4")
    end
  end

  context "#document_code" do
    it "should return the correct value" do
      expect(result.document_code).to eq("ID")
    end
  end

  context "#document_number" do
    it "should return the correct value" do
      expect(result.document_number).to eq("T22000129")
    end
  end

  context "#document_number_check_digit" do
    it "should return the correct value" do
      expect(result.document_number_check_digit).to eq("3")
    end
  end

  context "#expiration_date" do
    it "should return expiration_date as Date" do
      expected = Date.new(2020, 10, 31)

      expect(result.expiration_date).to eq(expected)
    end
  end

  context "#expiration_date_check_digit" do
    it "should return the correct value" do
      expect(result.expiration_date_check_digit).to eq("5")
    end
  end

  context "#first_name" do
    it "should return the correct value" do
      expect(result.first_name).to eq("ERIKA")
    end
  end

  context "#issuing_state" do
    it "should return the correct value" do
      expect(result.issuing_state).to eq("D")
    end
  end

  context "#last_name" do
    it "should return the correct value" do
      expect(result.last_name).to eq("MUSTERMANN")
    end
  end

  context "#nationality" do
    it "should return the correct value" do
      expect(result.nationality).to eq("D")
    end
  end

  context "#optional1" do
    it "should return the correct value" do
      expect(result.optional1).to eq("")
    end
  end

  context "#optional2" do
    it "should return the correct value" do
      expect(result.optional2).to eq("")
    end
  end

  context "#sex" do
    it "should return nonspecified if empty" do
      expect(result.sex).to eq("nonspecified")
    end

    it "should return correct value if not empty" do
      result.instance_variable_set(:@sex, "m")
      expect(result.sex).to eq("m")
    end
  end
end

module MRZ
  module CheckDigit
    FACTORS = [7, 3, 1]

    def self.calculate(sequence)
      check_digit = sequence.split("").each_with_index.reduce(0) do |acc,(char, i)|
        asciiCode = char.ord

        normalized_code =
          case asciiCode
          when proc { |n| n == 60 }
            0
          when proc { |n| n >= 65 }
            asciiCode - 55
          when proc { |n| n >= 48 }
            asciiCode - 48
          else
            asciiCode
          end

        acc + normalized_code * FACTORS[i % 3]
      end

      check_digit % 10
    end
  end
end

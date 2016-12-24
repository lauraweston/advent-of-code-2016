require_relative "../day2/day2.rb"

describe BathroomCodeCalculator do
  describe "parser" do
    test_cases = [
      ["", []],
      ["ULL\nRRDDD\nLURDL\nUUUUD", ["ULL", "RRDDD", "LURDL", "UUUUD"]]
    ]
    test_cases.each do |test_case|
      it "parses the input into instructions for each digit" do
        calculator = BathroomCodeCalculator.new(test_case.first)
        expect(calculator.parse).to eq(test_case.last)
      end
    end
  end

  describe "single digit calculator" do
    test_cases = [
      ["", 5],
      ["U", 2],
      ["D", 8],
      ["L", 4],
      ["R", 6],
      ["ULL", 1],
      ["UUD", 5]
    ]
    test_cases.each do |test_case|
      it "converts instructions to a digit correctly" do
        calculator = BathroomCodeCalculator.new(test_case.first)
        starting_digit = 5
        expect(calculator.single_digit_calculator(starting_digit, test_case.first)).to eq(test_case.last)
      end
    end
  end

  describe "correctly calculates the four digit code, given a set of instructions" do
    test_cases = [
      ["U\nL", 21],
      ["UUU\nD", 25],
      ["ULL\nRRDDD\nLURDL\nUUUUD", 1985]
    ]
    test_cases.each do |test_case|
      it "parses the input into instructions for each digit" do
        calculator = BathroomCodeCalculator.new(test_case.first)
        expect(calculator.calculate).to eq(test_case.last)
      end
    end
  end
end

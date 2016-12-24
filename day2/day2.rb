class BathroomCodeCalculator
  STARTING_DIGIT = 5

  def initialize(input)
    @input = input
  end

  def calculate
    parse
    current_digit = STARTING_DIGIT
    code = instructions.map do |instruction|
      current_digit = single_digit_calculator(current_digit, instruction)
    end
    code.join("").to_i
  end

  def parse
    @instructions = input.split("\n")
  end

  def single_digit_calculator(starting_digit, instruction)
    path = instruction.split("")
    current_digit = starting_digit
    path.each do |letter|
      case letter
      when "U"
        onTopRow = current_digit < 4
        if !onTopRow
          current_digit -= 3
        end
      when "D"
        onBottomRow = current_digit > 6
        if !onBottomRow
          current_digit += 3
        end
      when "L"
        onLeftSide = current_digit == 1 || current_digit == 4 || current_digit == 7
        if !onLeftSide
          current_digit -= 1
        end
      when "R"
        onRightSide = current_digit == 3 || current_digit == 6 || current_digit == 9
        if !onRightSide
          current_digit += 1
        end
      end
    end
    current_digit
  end

  private
  attr_reader :input, :instructions, :current_digit
end

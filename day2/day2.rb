class BathroomCodeCalculator
  STARTING_POSITION = {
    x: 1,
    y: 1
  }

  KEYPAD = [
    [1,2,3],
    [4,5,6],
    [7,8,9]
  ]

  def initialize(input)
    @input = input
    @current_position = STARTING_POSITION.dup
  end

  def calculate
    parse
    code = instructions.map do |instruction|
      single_digit_calculator(instruction)
    end
    code.join("").to_i
  end

  def parse
    @instructions = input.split("\n")
  end

  def single_digit_calculator(instruction)
    path = instruction.split("")
    code_position = current_position
    path.each do |letter|
      case letter
      when "U"
        if code_position[:y] > 0
          code_position[:y] -= 1
        end
      when "D"
        if code_position[:y] < 2
          code_position[:y] += 1
        end
      when "L"
        if code_position[:x] > 0
          code_position[:x] -= 1
        end
      when "R"
        if code_position[:x] < 2
          code_position[:x] += 1
        end
      end
    end
    @current_position = code_position
    x = code_position[:x]
    y = code_position[:y]
    KEYPAD[y][x]
  end

  private
  attr_reader :input, :instructions, :current_position
end

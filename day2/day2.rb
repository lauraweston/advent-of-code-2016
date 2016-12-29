class StartPosition
  NUMERIC = {
    x: 1,
    y: 1
  }

  ALPHANUMERIC = {
    x: 0,
    y: 2
  }
end

class Keypad
  NUMERIC = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ]

  ALPHANUMERIC = [
    [nil, nil, 1,   nil, nil],
    [nil, 2,   3,   4,   nil],
    [5,   6,   7,   8,   9],
    [nil, "A", "B", "C", nil],
    [nil, nil, "D", nil, nil]
  ]
end


class BathroomCodeCalculator
  def initialize(input, keypad, start_position)
    @input = input
    @keypad = keypad
    @current_position = start_position.dup
  end

  def calculate
    parse
    code = instructions.map do |instruction|
      single_digit_calculator(instruction)
    end
    code.join("")
  end

  def parse
    @instructions = input.split("\n")
  end

  def single_digit_calculator(instruction)
    path = instruction.split("")
    x = current_position[:x]
    y = current_position[:y]

    path.each do |letter|
      case letter
      when "U"
        if y > 0 && !(keypad[y - 1][x]).nil?
          y -= 1
        end
      when "D"
        if y < keypad.length - 1 && !(keypad[y + 1][x]).nil?
          y += 1
        end
      when "L"
        if x > 0 && !(keypad[y][x - 1]).nil?
          x -= 1
        end
      when "R"
        if x < (keypad[y].length - 1) && !(keypad[y][x + 1]).nil?
          x += 1
        end
      end
    end

    @current_position = {x: x, y: y}
    keypad[y][x]
  end

  private
  attr_reader :input, :keypad, :instructions, :current_position
end

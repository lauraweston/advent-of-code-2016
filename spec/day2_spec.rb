require_relative "../day2/day2.rb"

describe BathroomCodeCalculator do
  describe "parser" do
    test_cases = [
      ["", []],
      ["ULL\nRRDDD\nLURDL\nUUUUD", ["ULL", "RRDDD", "LURDL", "UUUUD"]]
    ]
    test_cases.each do |test_case|
      it "parses the input into instructions for each digit" do
        calculator = BathroomCodeCalculator.new(test_case.first, Keypad::NUMERIC, StartPosition::NUMERIC)
        expect(calculator.parse).to eq(test_case.last)
      end
    end
  end

  describe "single digit numeric calculator" do
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
      it "converts #{test_case.first} to a digit correctly" do
        calculator = BathroomCodeCalculator.new(test_case.first, Keypad::NUMERIC, StartPosition::NUMERIC)
        expect(calculator.single_digit_calculator(test_case.first)).to eq(test_case.last)
      end
    end
  end

  describe "single digit alphanumeric calculator" do
    test_cases = [
      ["", 5],
      ["U", 5],
      ["D", 5],
      ["L", 5],
      ["R", 6],
      ["ULL", 5],
      ["UUD", 5],
      ["RRDDD", "D"],
    ]
    test_cases.each do |test_case|
      it "converts #{test_case.first} to a digit correctly" do
        calculator = BathroomCodeCalculator.new(test_case.first, Keypad::ALPHANUMERIC, StartPosition::ALPHANUMERIC)
        expect(calculator.single_digit_calculator(test_case.first)).to eq(test_case.last)
      end
    end
  end

  describe "correctly calculates the four digit code, given a set of instructions" do
    test_cases = [
      ["U\nL", "21", "55"],
      ["UUU\nD", "25", "55"],
      ["ULL\nRRDDD\nLURDL\nUUUUD", "1985", "5DB3"],
      ["DLUUULUDLRDDLLLUDULLULLRUURURLUULDUUUDLDDRUDLUULLRLDDURURDDRDRDLDURRURDLDUURULDDULDRDDLDLDLRDRUURLDLUDDDURULRLLLLRLULLUDRDLDUURDURULULULRLULLLULURLRDRDDDDDDDLRLULUULLULURLLDLRLUDULLDLLURUDDLDULDLULDDRLRLRDDLRURLLLURRLDURRDLLUUUUDRURUULRLDRRULLRUDLDRLUDRDRDRRDDURURRDRDRUDURDLUDRUDLRRULDLRDDRURDDUUDLDRDULDDRRURLLULRDRURLRLDLLLUULUUDLUDLDRRRRDUURULDUDUDRLDLLULLLRDDDDDLRDDLLUULLRRRDURLRURDURURLUDRRLRURDRDRRRRULUDLDRDULULRUDULLLUDRRLRLURDDURULDUUDULLURUULRDRDULRUUUDURURDDRRUDURRLRDRULRUUU
        LDRURRUUUULDRDDDLLULDRUDDRLLDLDRDLRUDDDLDDULULULLRULDUDRRDLRUURURDRURURDLLRUURDUUDRLDURDRDLRRURURDUUUURUURRLLLDRDUURRRRURULUUUDLUDDRUURRLDULRDULRRRRUDURRLURULRURRDRDLLDRRDUDRDURLDDRURULDRURUDDURDLLLUURRLDRULLURDRDRLDRRURRLRRRDDDDLUDLUDLLDURDURRDUDDLUDLRULRRRDRDDLUDRDURDRDDUURDULRRULDLDLLUDRDDUDUULUDURDRLDURLRRDLDDLURUDRLDUURLLRLUDLLRLDDUDLLLRRRLDLUULLUDRUUDRLDUUUDUURLRDDDDRRDRLDDRDLUDRULDDDRDUULLUUUUULDULRLLLRLLDULRDUDDRDDLRRLRDDULLDURRRURDDUDUDDRLURRLUUUULLDRDULUUDRDULDLLUDLURDLLURRDLUULURRULRLURRRRRUURDDURLRLLDDLRRDUUURDRDUDRDDDLLDDRDRRRLURRDUULULULULRRURDDLDDLLLRUDDDDDDLLLRDULURULLRLRDRR
        DDRLLLDLRRURRDLDDRUURRURRLRRRRUURUURDLURRRDDLRUDRURLUURLLRRLRLURLURURDULLLLDLRURULUUDURRLULRDRDRRDDLLULRLUDLUUUDRLLRRURRLDULDDLRRLUUUUDDLRLDRLRRDRDLDDURDDRDDLDLURLRRRDDUDLLRLRLURRRRULLULLLLDRLDULDLLDULRLDRDLDDRRDDDDRUDRLLURULRLDDLLRRURURDDRLLLULLULDDRDLDDDLRLLDRLDRUURRULURDDRLULLDUURRULURUUDULLRUDDRRLLDLLRDRUDDDDLLLDDDLLUUUULLDUUURULRUUDUUUDDLDURLDRDRRLLUDULDLUDRLLLDRRRULUUDDURUDRLUDDRRLLDUDUURDDRURLUURDURURURRUUDUDDLLLDRRRURURRURDLRULLDUDRLRLLRUDRUDLR
        RRRDRLRURLRRLUURDRLDUURURLRDRRUDLLUUDURULLUURDLLDRRLURRUDUUDRRURLRRDULLDDLRRRUDUUDUUDLDDDLUUDLDULDDULLDUUUUDDUUDUDULLDDURRDLRRUDUDLRDUULDULRURRRLDLLURUDLDDDRRLRDURDLRRLLLRUDLUDRLLLRLLRRURUDLUDURLDRLRUDLRUULDRULLRLDRDRRLDDDURRRUDDDUDRRDRLDDRDRLLRLLRDLRDUDURURRLLULRDRLRDDRUULRDDRLULDLULURDLRUDRRDDDLDULULRDDRUDRLRDDRLDRDDRRRDUURDRLLDDUULRLLLULLDRDUDRRLUUURLDULUUURULLRLUDLDDLRRDLLRDDLRDRUUDURDDLLLDUUULUUDLULDUDULDRLRUDDURLDDRRRDLURRLLRRRUDDLDDRURDUULRUURDRRURURRRUUDUDULUDLUDLLLUUUULRLLRRRRDUDRRDRUDURLUDDLDRDLDDRULLRRULDURUL
        DLLLRDDURDULRRLULURRDULDLUDLURDDURRLLRRLLULRDLDRDULRLLRDRUUULURRRLLRLDDDRDRRULDRRLLLLDLUULRRRURDDRULLULDDDLULRLRRRUDRURULUDDRULDUDRLDRRLURULRUULLLRUURDURLLULUURUULUUDLUDLRRULLLRRLRURDRRURDRULRURRUDUDDDRDDULDLURUDRDURLDLDLUDURLLRUULLURLDDDURDULRLUUUDLLRRLLUURRDUUDUUDUURURDRRRRRRRRRUDULDLULURUDUURDDULDUDDRDDRDRLRUUUUDLDLRDUURRLRUUDDDDURLRRULURDUUDLUUDUUURUUDRURDRDDDDULRLLRURLRLRDDLRUULLULULRRURURDDUULRDRRDRDLRDRRLDUDDULLDRUDDRRRD", "36629", "99C3D"]
      ]
      test_cases.each do |test_case|
        it "converts #{test_case.first} to a numeric code correctly" do
          calculator = BathroomCodeCalculator.new(test_case.first, Keypad::NUMERIC, StartPosition::NUMERIC)
          expect(calculator.calculate).to eq(test_case[1])
        end
      end
      test_cases.each do |test_case|
        it "converts #{test_case.first} to an alphanumeric code correctly" do
          calculator = BathroomCodeCalculator.new(test_case.first, Keypad::ALPHANUMERIC, StartPosition::ALPHANUMERIC)
          expect(calculator.calculate).to eq(test_case.last)
        end
      end
    end
  end

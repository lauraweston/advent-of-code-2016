require_relative "../day4/day4.rb"

describe "filter real rooms" do
  describe "#parse" do
    it "parses a room name into a hash of encrypted name, sector id and checksum" do
      expect(parse("aaaaa-bbb-z-y-x-123[abxyz]")).to eq({
        encrypted_name: "aaaaabbbzyx",
        sector_id: 123,
        checksum: "abxyz"
      })
    end
  end

  describe "#get_5_most_common_letters" do
    it "sorts the letters in the encrypted name by number of occurences" do
        expect(get_5_most_common_letters("aaaaabbbzzyyyyx")).to eq "aybzx"
    end

    it "finds the most common 5 letters in the encrypted name" do
      expect(get_5_most_common_letters("aaaaabbbzzyyyyxkkkkkkkkkk")).to eq "kaybz"
    end

    it "sorts the letters of equal frequency alphabetically" do
      expect(get_5_most_common_letters("abcdefgh")).to eq "abcde"
    end
  end

  describe "#real_room?" do
    it "returns true if a room name is real" do
      real = {
        encrypted_name: "aaaaabbbzyx",
        sector_id: 123,
        checksum: "abxyz"
      }

      expect(real_room?(real)).to eq true
    end
    it "returns false if a room name is a decoy" do
      decoy =   {
          encrypted_name: "totallyrealroom",
          sector_id: 200,
          checksum: "decoy"
        }

      expect(real_room?(decoy)).to eq false
    end
  end

  describe "#filter_real_rooms" do
    it "filters real rooms from a list of room names" do
      rooms = [{
        encrypted_name: "aaaaabbbzyx",
        sector_id: 123,
        checksum: "abxyz"
      },
      {
        encrypted_name: "totallyrealroom",
        sector_id: 200,
        checksum: "decoy"
      },
      {
        encrypted_name: "abcdefgh",
        sector_id: 987,
        checksum: "abcde"
      },
      {
        encrypted_name: "notarealroom",
        sector_id: 404,
        checksum: "oarel"
      }]

      expect(filter_real_rooms(rooms)).to eq [{
        encrypted_name: "aaaaabbbzyx",
        sector_id: 123,
        checksum: "abxyz"
      },
      {
        encrypted_name: "abcdefgh",
        sector_id: 987,
        checksum: "abcde"
      },
      {
        encrypted_name: "notarealroom",
        sector_id: 404,
        checksum: "oarel"
      }]
    end
  end

  describe "#get_sum_of_sector_ids" do
    it "adds the sector ids of each room in a list" do
    rooms = [{
      encrypted_name: "aaaaabbbzyx",
      sector_id: 123,
      checksum: "abxyz"
    },
    {
      encrypted_name: "abcdefgh",
      sector_id: 987,
      checksum: "abcde"
    },
    {
      encrypted_name: "notarealroom",
      sector_id: 404,
      checksum: "oarel"
    }]
    expect(get_sum_of_sector_ids(rooms)).to eq 1514
    end
  end

  describe "#get_sum_of_sector_ids_of_real_rooms" do
    it "adds the sector ids of each real room in the list" do
      input = ["aaaaa-bbb-z-y-x-123[abxyz]\n", "totally-real-room-200[decoy]\n", "a-b-c-d-e-f-g-h-987[abcde]\n", "not-a-real-room-404[oarel]\n"]

      expect(get_sum_of_sector_ids_of_real_rooms(input)).to eq 1514
    end

    it "finds the sum of sector ids for puzzle input" do
      input = File.new("./day4/day4_input.txt").readlines
      expect(get_sum_of_sector_ids_of_real_rooms(input)).to eq 361724
    end
  end
end

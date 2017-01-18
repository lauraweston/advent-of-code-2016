def get_sum_of_sector_ids_of_real_rooms(input)
  rooms = input.map { |room| parse(room) }
  real_rooms = filter_real_rooms(rooms)
  get_sum_of_sector_ids(real_rooms)
end

def parse(room)
  room_parts = room.partition(/\d+/)

  { encrypted_name: room_parts.first.gsub("-", ""),
    sector_id: room_parts[1].to_i,
    checksum: room_parts.last.chomp.gsub(/[\[\]]/, "")
  }
end

def filter_real_rooms(rooms)
  rooms.select { |room| real_room?(room) }
end

def real_room?(room)
  get_5_most_common_letters(room[:encrypted_name]) == room[:checksum]
end

def get_5_most_common_letters(string)
  letters = string.split("")
  occurences = letters.each_with_object(Hash.new(0)) do |letter, counts|
    counts[letter] += 1
  end
  occurences.sort_by { |letter| [-letter[1], letter[0]] }
    .map { |letter_count| letter_count.first }
    .take(5)
    .join("")
end

def get_sum_of_sector_ids(rooms)
  rooms.inject(0) { |sum, room| sum + room[:sector_id] }
end

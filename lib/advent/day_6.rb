class Advent::Day6
  include Advent::Helper

  RUN = %i(start_of_packet start_of_message)

  # Part 1 of the challenge - looking for the position of the first character
  # where the 4 preceding characters are all unique.
  #
  # @return [Integer] position of the character
  def start_of_packet
    find_pattern(4)
  end

  # Part 2 of the challenge - looking for the position of the first character
  # where the 14 preceding characters are all unique.
  #
  # @return [Integer] position of the character
  def start_of_message
    find_pattern(14)
  end

  private

  # Does the work - finds the index of the item directly after then uniq_count of
  # items that are all unique
  #
  # @param uniq_count [Integer] the number of uniq items to look for
  # @return [Integer] the index of the item
  def find_pattern(uniq_count)
    stream.each_with_index do |char, i|
      next if i < uniq_count
      last_14 = stream[(i-uniq_count)..(i-1)]
      return i if last_14.uniq.count == uniq_count
    end
  end

  # The stream of data from the input file
  #
  # @return [Array] an array of characters
  def stream
    get_input("input_day_6.txt").first.split("")
  end
end

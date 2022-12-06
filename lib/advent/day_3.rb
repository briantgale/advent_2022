class Advent::Day3
  include Advent::Helper

  RUN = %i(total_priority elf_group_priorities)
  PRIORITY = (("a".."z").to_a + ("A".."Z").to_a)

  # Computes the total priority for the first scenario - each line
  #
  # @return [Integer] total priority
  def total_priority
    priorities = get_input("input_day_3.txt").map do |rucksack|
      char = common_char(rucksack)
      priority_for_char(char)
    end

    priorities.reduce(&:+)
  end

  # Computes the total priority for the second scenario - 3 grouped lines
  #
  # @return [Integer] total priority for grouped lines
  def elf_group_priorities
    priorities = get_input("input_day_3.txt").each_slice(3).map do |slice|
      char = common_group_char(slice)
      priority_for_char(char)
    end

    priorities.reduce(&:+)
  end

  private

  # Determines the common character for 3 strings
  #
  # @param group[Array] 3 strings to compare
  # @return [String] a common character
  def common_group_char(group)
    raise "bad group" unless group.count == 3
    a = group.first.split("")
    b = group[1].split("")
    c = group.last.split("")
    (a & b & c).first
  end

  # Determines the common character between a single string that's cut in half
  #
  # @param rucksack[String] a single string
  # @return [String] a common character
  def common_char(rucksack)
    size = rucksack.size
    half = size / 2
    comp_1 = rucksack[0..(half - 1)]
    comp_2 = rucksack[half..size]
    union = comp_1.split("") & comp_2.split("")
    union.first
  end

  # Determines the priority on the given scale
  # 
  # @param char [String] a single character
  # @return [Integer] the priority
  def priority_for_char(char)
    i = PRIORITY.find_index(char)
    i + 1
  end
end

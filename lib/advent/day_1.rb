class Advent::Day1
  include Advent::Helper

  RUN = %i(top top_3)

  # The number of calories packed but the elf that packed the most
  def top
    add_max(1)
  end
  
  # Part 2 - the number of calories packed by the top 3 elfs
  def top_3
    add_max(3)
  end

  private

  # Gets the n max numbers from the grouped items and reduces them to a single int
  # 
  # @param number [Integer] the number of items to add
  # @return [Integer] the combined number
  def add_max(number)
    totals = group_input.map { |elf| elf.reduce(&:+) }
    totals.max(number).reduce(&:+)
  end

  # Group up the input values following advent's instructions - A blank line
  # denotes the end of a group
  #
  # @return [Array] an array of arrays
  def group_input
    grouped = []
    current_group = []

    get_input("input_day_1.txt").each do |d|
      if d.empty?
        grouped << current_group
        current_group = []
        next
      end

      current_group << d.to_i
    end

    # Make sure the last group gets added
    grouped << current_group unless current_group.empty?

    grouped
  end

end

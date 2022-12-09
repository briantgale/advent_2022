class Advent::Day5Base
  include Advent::Helper

  # Set up an array to use and populate it with data
  def initialize
    @stacks = []
    set_initial_stacks
  end

  private

  # The "top" of the stack is the end of the array
  # [
  #   [bottom, middle, top],
  #   [bottom, top]
  # ]
  #
  # Parses the input file for the initial stack configuration, and
  # sets the array to match what is in the file
  #
  def set_initial_stacks
    data = get_input("input_day_5.txt")

    # Get the portion of the file that's the initial stacks
    i = data.find_index { |i| i == "" }
    stuff = data.first(i)
    stuff.reverse.each_with_index do |line, idx|
      if idx == 0
        set_stack_arrays(line.gsub(" ", "").split("").last.to_i)
        next
      end

      line.split("").each_slice(4).with_index do |slice, slice_idx|
        item = slice[1]
        @stacks[slice_idx] << item if item.match(/\w/)
      end
    end
  end

  # Creates empty arrays in the stacks instance variable for the
  # number of stacks that were present in the file.
  def set_stack_arrays(num_stacks)
    @stacks = []
    num_stacks.times { @stacks << [] }
  end


end

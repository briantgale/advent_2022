class Advent::Day5 < Advent::Day5Base

  RUN = %i(top_stack_items)

  # Performs the stack moves and provides output
  #
  # @return [String] the top items in each stack
  def top_stack_items
    perform_moves
    @stacks.map { |s| s.last }.join("")
  end

  private

  # Figures out which part of the input is the moves and, parses it,
  # and then loops over them all and does the moves
  #
  def perform_moves
    data = get_input("input_day_5.txt")
    first_move_idx = data.find_index { |i| i.match(/move.*/) }

    data[first_move_idx..(data.length - 1)].each do |move|
      match = move.match /^move\s(\d+)\sfrom\s(\d+)\sto\s(\d+)$/
      num_to_move, from_stack, to_stack = match.captures.map(&:to_i)
      num_to_move.times do
        move(from_stack, to_stack)
      end
    end
  end

  # Does a single move - pops off the last item of the array and moves it to
  # another stack. This expects the non-adjusted index for both params.
  #
  # @param from_stack [Integer] the stack to move from
  # @param to_stack [Integer] the stack to move to
  def move(from_stack, to_stack)
    item = @stacks[from_stack - 1].pop
    @stacks[to_stack - 1] << item
  end

end

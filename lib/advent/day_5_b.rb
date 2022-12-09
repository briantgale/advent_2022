class Advent::Day5B < Advent::Day5Base

  RUN = %i(top_stack_items)

  # Does the work
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
      move(num_to_move, from_stack, to_stack)
    end
  end

  # Does a single move - pops off the last n items of the array and moves it to
  # another stack in the same order. This expects the non-adjusted index for 
  # both params.
  #
  # @param num_to_move [Integer] the number to move from one stack to the next
  # @param from_stack [Integer] the stack to move from
  # @param to_stack [Integer] the stack to move to
  def move(num_to_move, from_stack, to_stack)
    items = @stacks[from_stack - 1].pop(num_to_move)
    @stacks[to_stack - 1] += items
  end

end

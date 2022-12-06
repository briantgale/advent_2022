class Advent::Day2
  include Advent::Helper

  RUN = %i(score)

  MOVES = {
    "a": :rock,
    "b": :paper,
    "c": :scissors,
    "x": :rock,
    "y": :paper,
    "z": :scissors
  }

  def score
    data = get_input("input_day_2.txt")

    scores = data.map do |d|
      values = d.downcase.split(" ")
      compute_score(values.last, outcome(*values))
    end

    scores.reduce(&:+)
  end

  # A - Rock
  # B - Paper
  # C - Scissors
  # X - Rock
  # Y - Paper
  # Z - Scissors
  def outcome(them, me)
    their_move = MOVES[them.to_sym]
    my_move = MOVES[me.to_sym]

    return :draw if their_move == my_move
    return :loss if their_move == :scissors && my_move == :paper
    return :loss if their_move == :rock && my_move == :scissors
    return :loss if their_move == :paper && my_move == :rock
    return :win if their_move == :rock && my_move == :paper
    return :win if their_move == :scissors && my_move == :rock
    return :win if their_move == :paper && my_move == :scissors
    
    raise "I don't know how to handle this outcome"
  end

  # Rock - 1 Point
  # Paper - 2 Points
  # Scissors - 3 Points
  # Lost - 0 Points
  # Draw - 3 Points
  # Win - 6 Points
  def compute_score(move, outcome)
    play_score = case MOVES[move.to_sym]
                 when :rock
                   1
                 when :paper
                   2
                 when :scissors
                   3
                 end

    outcome_score = case outcome
                    when :loss
                      0
                    when :draw
                      3
                    when :win
                      6
                    end

    play_score + outcome_score
  end

end

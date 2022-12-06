class Advent::Day2B < Advent::Day2Base
  include Advent::Helper

  RUN = %i(score)

  def score
    data = get_input("input_day_2.txt")

    scores = data.map do |d|
      values = d.downcase.split(" ")
      compute_score(move_for_outcome(*values), OUTCOMES[values.last.to_sym])
    end

    scores.reduce(&:+)
  end

  private

  def move_for_outcome(them, out)
    their_move = MOVES[them.to_sym]
    outcome = OUTCOMES[out.to_sym]

    return their_move if outcome == :draw
    return :paper if their_move == :rock && outcome == :win
    return :scissors if their_move == :rock && outcome == :loss
    return :rock if their_move == :scissors && outcome == :win
    return :rock if their_move == :paper && outcome == :loss
    return :paper if their_move == :scissors && outcome == :loss
    return :scissors if their_move == :paper && outcome == :win

    raise "I don't know how to handle this outcome"
  end

end

class Advent::Day2 < Advent::Day2Base
  include Advent::Helper

  RUN = %i(score)

  # Computes the score assuming the values in the input are both
  # rock paper scissors
  #
  # @return [Integer] the score
  def score
    data = get_input("input_day_2.txt")

    scores = data.map do |d|
      values = d.downcase.split(" ")
      compute_score(MOVES[values.last.to_sym], outcome(*values))
    end

    scores.reduce(&:+)
  end

  private

  # First scenario assumes that XYZ are rock paper sciscors. This
  # computes the outcome (win, lose, draw) based on the opponents move
  # and my move
  # 
  # @param them [String] their move
  # @param me [String] my move
  # @return [Symbol] outcome
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

end

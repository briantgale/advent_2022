class Advent::Day2Base
  MOVES = {
    "a": :rock,
    "b": :paper,
    "c": :scissors,
    "x": :rock,
    "y": :paper,
    "z": :scissors
  }

  OUTCOMES = {
    "x": :loss,
    "y": :draw,
    "z": :win
  }

  private

  # Rock - 1 Point
  # Paper - 2 Points
  # Scissors - 3 Points
  # Lost - 0 Points
  # Draw - 3 Points
  # Win - 6 Points
  def compute_score(move, outcome)
    play_score = case move
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

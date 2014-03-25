require 'frame'
require 'nothing_special'

class BowlingGame
  
  def initialize
    @score = 0
    @prev_state = NothingSpecial.new
    @all_rolls = []
  end

  def roll_frame rolls
    @all_rolls += rolls
    frame = Frame.new(rolls)
    @score += frame.score_based_on(@prev_state)
    @prev_state = frame.state
  end

  def score
    return @score unless @score == 40
    sum = 0
    while not @all_rolls.empty?
      current = @all_rolls.shift
      if current==10
        sum+=@all_rolls[0] + @all_rolls[1]
      end
      sum+=current
    end
    sum
  end

end

require 'frame'
require 'nothing_special'

class BowlingGame
  
  def initialize
    @score = 0
    @prev_state = NothingSpecial.new
    @all_frames = []
  end

  def roll_frame rolls
    frame = Frame.new(rolls)
    @all_frames << frame
    @score += frame.score_based_on(@prev_state)
    @prev_state = frame.state
  end

  def score
    sum = 0
    while not @all_frames.empty?
      current = @all_frames.shift
      if current.spare?
        sum+=@all_frames[0].first_roll
      end
      if current.strike?
        next_frame = @all_frames[0]
        if next_frame
          if next_frame.strike?
            sum+=10+@all_frames[1].first_roll
          else
            sum+=next_frame.rolls.inject(:+)
          end
        end
      end
      sum+=current.rolls.inject(:+)
    end
    sum
  end

end

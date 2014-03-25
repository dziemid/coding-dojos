require 'frame'

class BowlingGame
  
  def initialize
    @score = 0
    @all_frames = []
  end

  def roll_frame rolls
    frame = Frame.new(rolls)
    @all_frames << frame
  end

  def score
    sum = 0
    frames = @all_frames.take(10)

    while not frames.empty?
      current = frames.shift
      @all_frames.shift
      
      

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
      sum+=bonus(current, @all_frames)
      sum+=current.raw_score
    end
    sum
  end

  def bonus(current, frames)
    if current.spare?
        return frames[0].first_roll
    end
    0
  end

end

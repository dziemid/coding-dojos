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

      sum+=bonus(current, @all_frames)
      sum+=current.raw_score
    end
    sum
  end

  def bonus(current, frames)
    current.bonus(frames)
  end

end

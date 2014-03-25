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
    frames = @all_frames.take(10)

    frames.map do |frame| 
      frame.raw_score + bonus(frame, @all_frames)
    end.reduce(:+)
 
  end

  def bonus(current, frames)
    current.bonus(frames)
  end

end

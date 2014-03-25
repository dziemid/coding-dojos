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
    @all_frames.take(10).map do |frame| 
      frame.raw_score + frame.bonus(@all_frames)
    end.reduce(:+)
 
  end

end

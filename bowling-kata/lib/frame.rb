require 'invalid_frame_exception'

class Frame
  attr_reader :rolls

  def initialize(rolls)
    raise InvalidFrameException if is_invalid?(rolls)
    @rolls = rolls
  end

  def bonus(frames)

    index = frames.find_index(self)

    return frames[index+1].first_roll if spare?

    if strike?
        next_frame = frames[index+1]
        if next_frame
          if next_frame.strike?
            return 10+frames[index+2].first_roll
          else
            return next_frame.rolls.inject(:+)
          end
        end
      end
    0

  end
  
  def raw_score
    rolls.reduce(:+)
  end

  def first_roll
    rolls.first
  end

  def second_roll
    rolls[1]
  end

  # private
  def strike?
    rolls[0] == 10
  end

  def spare?
    rolls.size == 2 && (raw_score == 10)
  end

  private

  def is_invalid?(rolls)
    rolls.empty? || (rolls.size == 1 && rolls.first != 10)
  end


end

require 'invalid_frame_exception'

class Bonus
  def self.for (frame)
    return StrikeBonus.new if frame.strike?
    return SpareBonus.new if frame.spare?
    NoBonus.new
  end
end

class NoBonus

  def bonus_based_on(frames)
    0
  end

end

class StrikeBonus

  def bonus_based_on(frames)
    next_frame = frames[0]
    if next_frame
      if next_frame.strike?
        return 10+frames[1].first_roll
      else
        return next_frame.rolls.inject(:+)
      end
    end
    0
  end

end

class SpareBonus

  def bonus_based_on(frames)
    frames[0].first_roll
  end

end


class Frame
  attr_reader :rolls

  def initialize(rolls)
    raise InvalidFrameException if is_invalid?(rolls)
    @rolls = rolls
    @bonus = Bonus.for(self)
  end

  def bonus_based_on(frames)
    index = frames.find_index(self)
    @bonus.bonus_based_on(frames.drop(index+1))
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

require 'invalid_frame_exception'

class Bonus
  def self.for (frame)
    return StrikeBonus.new if frame.strike?
    return SpareBonus.new if frame.spare?
    NoBonus.new
  end
end

class NoBonus

  def based_on(frames)
    0
  end

end

class StrikeBonus

  def based_on(frames)
    return 0 if frames.empty?
    if frames[0].strike?
      return 10+frames[1].first_roll
    else
      return frames[0].rolls.inject(:+)
    end
  end

end

class SpareBonus

  def based_on(frames)
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
    frames_after_me = frames.drop(frames.find_index(self)+1)
    @bonus.based_on(frames_after_me)
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

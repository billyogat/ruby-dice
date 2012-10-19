module Dice
  class Roller

    NUM_OF_DICE = 0
    SIDES = 1

    def initialize
      @random = Random.new
    end

    def self.roll_dice(cmd_line)
      if cmd_line.valid_arguments? && cmd_line.valid_dice?
        Dice::Roller.new.roll_dice(cmd_line.dice)
      elsif !cmd_line.valid_arguments?
        raise TooManyArguments.exception("too many arguments: #{cmd_line.args.inspect}")
      elsif !cmd_line.valid_dice?
        raise InvalidDice.exception("invalid dice: #{cmd_line.dice}")
      end
    end

    def roll_dice(dice_to_roll)
      dice = dice_to_roll.split(/\+/).map do
      |d|
        if d.size == 1
          {"mod" => [d.to_i]}
        else
          roll_elements = d.split(/d/).map { |ele| ele.to_i }
          num_dice = roll_elements[NUM_OF_DICE]
          sides = roll_elements[SIDES]

          if roll_elements[NUM_OF_DICE] == 0
            roll = roll_die(sides)
            {d => [roll]}
          else
            a = Array.new(num_dice).map { |i| roll_die(sides) }
            {d => a}
          end
        end
      end
    end

    def roll_die(sides)
      @random.rand(1..sides)
    end

  end

  #
  # Raises when there are too many arguments.
  #
  class TooManyArguments < RuntimeError

  end

  #
  # Raises when the dice are invalid.
  #
  class InvalidDice < RuntimeError

  end

end

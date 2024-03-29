module Dice

  # Rolls the dice. Uses Random to generate the roll results.
  class Roller

    # Location in roll_elements where the number of dice is stored.
    NUM_OF_DICE = 0
    # Location in roll_elements where the number of sides is stored.
    SIDES = 1

    private_constant :SIDES, :NUM_OF_DICE

    # Initializes a new Random object.
    def initialize
      @random = Random.new
    end

    # For use with the command line. Use {Roller#roll_dice} when making api calls.
    #
    # @param cmd_line [CommandLine]
    #
    # @return [Array[Hash{String => Array[Integer]}]] roll results for the different dice groups
    def self.roll_dice(cmd_line)
      if cmd_line.valid_arguments? && cmd_line.valid_dice?
        Dice::Roller.new.roll_dice(cmd_line.dice)
      elsif !cmd_line.valid_arguments?
        raise TooManyArguments.exception("too many arguments: #{cmd_line.args.inspect}")
      elsif !cmd_line.valid_dice?
        raise InvalidDice.exception("invalid dice: #{cmd_line.dice}")
      end
    end

    # Rolls the dice by splitting each section by its grouping (a grouping is separated by a + or -).
    # Each grouping is then rolled.
    #
    # @param dice_to_roll [String] the string representation of the roll
    #
    # @return [Array[Hash{String => Array[Integer]}]] roll results for the different dice groups
    # @api
    def roll_dice(dice_to_roll)
      dice = dice_to_roll.scan(/[+-]?\d*d\d+|[+-]?\d+/).map do
      |d|
        roll_elements = d.split(/d/)
        if roll_elements.size == 1
          {"mod" => [d.to_i]}
        else
          sides = roll_elements[SIDES].to_i
          sign = ""
          num_dice =
            if roll_elements[NUM_OF_DICE][1].nil?
              sign = "+"
              roll_elements[NUM_OF_DICE][0].to_i # no sign so the num sides is at 0 (case for the first dice combo)
            elsif
              sign = roll_elements[NUM_OF_DICE][0]
              roll_elements[NUM_OF_DICE][1].to_i
            end

          roll_results = num_dice.times.map do
            if sign == "+"
              roll_die(sides)
            elsif sign == "-"
              roll_die(sides) * -1
            end
          end

          {d => roll_results}
        end
      end
    end

    # Rolls a single die
    #
    # @param sides [Integer] number of sides on the dice
    #
    # @return [Integer] results of the roll, between 1 and +sides+
    def roll_die(sides)
      @random.rand(1..sides)
    end

  end

  # Raises when there are too many arguments.
  class TooManyArguments < RuntimeError

  end

  # Raises when the dice are invalid.
  class InvalidDice < RuntimeError

  end
end

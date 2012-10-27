module Dice

  # Formats the results of the dice roll into readable form.
  class Output

    # Create new output object with the required data.
    #
    # @param results [Hash] the results of a dice roll from Roller
    # @param verbose [Boolean] +false+ [answer only], +true+ [data from all rolls]
    def initialize(results, verbose)
      @sum = results.map { |h| h.values }.flatten.inject(:+)
      @display = ""
      @raw = results
      @verbose = verbose
    end

    # Format the data and return a String.
    #
    # @return [String] of the formatted data
    def format
      output = @sum.to_s

      if @verbose
        @raw.each do |h|
          @display << "#{h.keys[0]}:#{h.values[0]} "
        end

        output << " -- #{@display.strip}"
      end

      output
    end

  end
end

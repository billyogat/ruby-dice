module Dice
  class Output

    def initialize(results, verbose)
      @sum = results.map { |h| h.values }.flatten.inject(:+)
      @display = ""
      @raw = results
      @verbose = verbose
    end

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


require "optparse"

require_relative "version"

module Dice
  # Parses command line options.
  class CommandLine
    # * +options+ - the parsed options
    # * +args+ - the original arguments passed to the parser
    attr_reader :options, :args

    # Initializes parser and parses the option arguments.
    # ==== Arguments
    # * +args+ - +ARGV+ from the command line
    def initialize(args)
      @args = args
      @original_args = args.dup
      @options = {}
      @options[:verbose] = true
      @parser = OptionParser.new(args) do |opts|
        banner =  "Usage: roll [DICE]"
        banner << "\n       [DICE] in the following format:"
        banner << "\n       2d6 OR d6 OR 2d6+1d10 OR 2d6+5"
        opts.banner = banner
        opts.on("-V", "--[no-]verbose", "Displays verbose results (more than just the number rolled).") do |v|
          @options[:verbose] = v
        end
        opts.on_tail("-v", "--version", "Displays the version of Dice") do
          puts Dice::VERSION
          exit
        end
        opts.on_tail("-?", "--help", "Show available options.") do
          puts opts
          exit
        end
      end

      if args.size == 0
        puts @parser.help
        exit false
      end

      parse_successful = true
      begin
        @parser.parse!(args)
      rescue OptionParser::ParseError => e
        puts e
        raise e
      end

    end

    # Helper method used when parsing is complete. There should only be one
    # argument left after parsing, the dice roll(s).
    def valid_arguments?
      @args.size == 1
    end

    # Determines if the format of the dice roll(s) is correct.
    # Valid dice input follows this format:
    #   [num]d[num]([+ OR -][num]d[num])*([+ OR -][num])*
    # Where anything in between  <tt>()</tt> is optional and <tt>*</tt> means one or more.
    def valid_dice?
      match = /^\d*d\d+([+-]\d+d\d+)*([+-]\d*)*$/.match(@args[0])
      ! match.nil?
    end

    # Displays the help text.
    def help
      @parser
    end

    # Returns the dice roll(s) from the command line.
    def dice
      @args[0]
    end
  end
end

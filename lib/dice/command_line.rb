
require "optparse"

require_relative "version"

module Dice
  class CommandLine
    attr_reader :options, :args

    def initialize(args)
      @args = args
      @original_args = args.dup
      @options = {}
      @parser = OptionParser.new(args) do |opts|
        banner =  "Usage: roll [DICE]"
        banner << "\n       [DICE] in the following format:"
        banner << "\n       2d6 OR d6 OR 2d6+1d10 OR 2d6+5"
        opts.banner = banner
        opts.on("-V", "--verbose", "Displays verbose results (more than just the number rolled).") do
          @options[:verbose] = true
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

      begin
        @parser.parse!(args)
      rescue OptionParser::ParseError, OptionParser::NeedlessArgument => e
        puts e
        exit false
      end

    end

    def valid_arguments?
      @args.size == 1
    end

    def valid_dice?
      match = /^\d*d\d+(\+?\d?d\d+)*\+?\d*$/.match(@args[0])
      ! match.nil?
    end

    def help
      @parser
    end

    def dice
      @args[0]
    end
  end
end

# Dice

Dice is a command line dice roller using ruby's [Random](http://www.ruby-doc.org/core-1.9.3/Random.html) number
generator.

## Installation

### As a Ruby Gem

    $ gem install dice

### For Use Within Your Code

Add this line to your application's Gemfile:

    gem 'dice'

And then execute:

    $ bundle

## Usage

Dice can be used one of two ways; from the command line, or from an api call.

### Command Line

Once you have the gem installed or you downloaded the source from github,
[https://github.com/billyogat/dice](https://github.com/billyogat/dice).
Execute the `roll` command from you command line with a `dice` argument.

    $ roll 2d6
    6 -- 2d6:[4, 2]

The dice argument can contain one or more dice groups.

    $ roll 2d6+1d8
    13 -- 2d6:[5, 5] +1d8:[3]

As well as modifiers.

    $ roll 2d6+1d8+5
    23 -- 2d6:[5, 6] +1d8:[7] mod:[5]

All dice groups (except for the first) and modifiers can be positive[+] or negative[-]. But the dice argument must
follow this regual expression.

    ^\d*d\d+([+-]\d+d\d+)*([+-]\d*)*$

Verbose output is the default, if you would like only the result displayed add the `--[no-]verbose` option to the
command.

    $ roll --no-verbose 2d6+1d8+5
    18

### API Call

After adding the gem to your Gemfile you can make calls to the Roller by creating a new instances and calling
{Roller#roll_dice}.

    roller = Dice::Roller.new
    roller.roll_dice('2d6')
    => [{"2d6"=>[2, 1]}]

## How to Contribute

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

require_relative 'Cards'
require_relative 'Deck'
require_relative 'Game'
require_relative 'Runner'
require 'pry'

runner = Runner.new(ARGV[0].to_i, ARGV[1], ARGV[2].downcase == "true")
runner.start
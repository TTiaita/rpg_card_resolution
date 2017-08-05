require_relative 'Cards'
require_relative 'Deck'
require_relative 'Game'
require 'thread'
require 'pry'

@iterations = 10000000
@mutex = Mutex.new
@threads = []
@output = []
@players = []

@queue = Queue.new
for i in 1..5
	for ii in 1..5
		@queue << [i, ii]
	end
end

def run_test()
	q = @queue.pop
	a = q[0]
	b = q[1]
	result = Game.new(@iterations, @players[a], b).start
	@output << "Challenge: #{b}\tSkill: #{a}\tWin-rate: #{100*(result['wins']/@iterations.to_f)}%\t\tWins: #{result['wins']}\t\t Losses: #{result['losses']}"
end

for i in 1..5
	@players[i] = Player.new(i, nil)
end

puts "********"
puts "Starting"
puts "********"


for i in 1..@queue.size
	@threads << Thread.new {run_test()}
end

@threads.each do |t|
	t.join
end

puts "*******"
puts "Results"
puts "*******"

i = 0
@output.sort!
@output.each do |o|
	puts o
	i = (i + 1) % 5
	puts "\n" if i == 0
end

class Runner

end
class Runner
	def initialize(iterations, filepath, console)
		@filepath = filepath
		@iterations = iterations
		@console = console
		create_queue
		@threads = []
	end

	def start
		puts "Starting test run with #{@iterations} rounds per scenario...\n"
		@output = []
		create_threads
		wait_for_threads
		report
	end

	private
	def do_run
		q = @queue.pop
		result = Game.new(@iterations, q[1], q[0], q[2]).start
		msg = "Challenge: #{q[0]}\tSkill: #{q[1]}\tExtra draws: #{q[2]}\t"
		msg << "\tWin-rate: #{'%.4f' % (100*(result['wins']/@iterations.to_f))}%"
		msg << "\tWins: #{"%0#{@iterations.digits.count}d" % result['wins']}"
		msg << "\tLosses: #{result['losses']}"
		msg << "\tMean extras: #{'%.2f' % (result['extras']/@iterations.to_f)}"
		msg << "\tExtra-rate: #{'%.4f' % (100*(result['pushed']/@iterations.to_f))}%"
		@output << msg
	end

	def create_queue
		@queue = []
		for i in 1..5 #player skill
			for ii in 1..5 #challenge
				for iii in 0..3 #extra draws allowed
					@queue << [i, ii, iii]
				end
			end
		end
	end

	def create_threads
		for i in 1..@queue.size
			@threads << Thread.new {do_run}
		end
	end

	def wait_for_threads
		@threads.each do |t|
			t.join
		end
	end

	def report
		@output.sort!
		i = 0
		File.open(@filepath, 'w+') { |file|
			file.puts "-------\n--"
			@output.each do |o|
				file.puts o.gsub('\t', ', ')
				i += 1
				file.puts "--" if (i % 4 == 0)
				i %= 16
				file.puts "-------" if (i == 0)
			end
			file.puts "-------"
		}
		if (@console)
			i = 0
			puts "-------\n--"
			@output.each do |o|
				puts o
				i += 1
				puts "--" if (i % 4 == 0)
				i %= 20
				puts "-------" if (i == 0)
			end
			puts "-------"
		end
	end
end
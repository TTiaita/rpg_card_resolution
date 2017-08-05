class Game

	def initialize(iterations, skill, challenge, extra)
		@deck = Deck.new
		@iterations = iterations
		@skill = skill
		@challenge = challenge
		@extra = extra
	end

	def start
		result = play
	end

	private
	def play
		result = {"wins" => 0, "losses" => 0, "extras" => 0, "pushed" => 0}
		for i in 1..@iterations
			gm = draw_cards @challenge
			p = 0
			limit = @skill + @extra
			draws = 0
			pushed = false
			loop do
				p += draw_cards 1
				draws += 1
				if (draws > @skill)
					result["extras"] += 1 
					result["pushed"] += 1 if !pushed
					pushed = true
				end
				break if (p > gm) || (draws >= limit)
			end
			
			if (p > gm)
				result['wins'] += 1
			else
				result['losses'] += 1
			end
		end
		return result
	end

	def draw_cards(n)
		result = 0
		for i in 1..n
			result += @deck.draw.to_i
		end
		return result
	end
end
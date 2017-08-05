class Game

	def initialize(iterations, player, challenge)
		@deck = Deck.new
		@iterations = iterations
		@player = player
		@challenge = challenge
	end

	def start
		result = play
	end

	private
	def play
		result = {"wins" => 0, "losses" => 0}
		for i in 1..@iterations
			gm = draw_cards @challenge
			p = draw_cards @player.skill
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

Player = Struct.new(:skill, :behaviour)
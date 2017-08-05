class Deck
	def initialize
		@random = Random.new
		@discard = []
		create
	end

	def shuffle
		@discard = []
	end

	def empty?
		return @discard.count == 52
	end

	def draw
		shuffle if empty?
		i = 0
		loop do
			i = @random.random_number(52)
			break unless @discard.include? i
		end
		@discard << i
		return @cards[i]
	end

	private
	def create
		@cards = []
		for i in 0..51
			@cards << (Card.new i)
		end
	end
end
class Card
	attr_reader :face, :suit, :value

	def initialize(card_num)
		card = 1 + (card_num % 13)
		@value = (card > 10) ? 10 : card
		@suit = case card_num/13
			when 0
				'♠'
			when 1
				'♦'
			when 2
				'♣'
			when 3
				'♥'
			end
	end

	def to_s
		@suit + @value.to_s
	end

	alias_method :to_i, :value
end

class Deck
	def initialize
		@random = Random.new
		create
		shuffle
	end

	def shuffle
		@discard = []
	end

	def order
		@cards.sort
	end

	def empty?
		return @discard.count == 52
	end

	def draw
		return "No cards" if empty?
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

def test
	d = Deck.new
	for i in 0..54
		puts d.draw.to_s
	end
end
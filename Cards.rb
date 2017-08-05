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



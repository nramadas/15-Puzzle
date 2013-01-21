class Piece
	attr_reader :value

	def initialize(value)
		@value = value
	end

end

class EmptyPiece < Piece
	attr_reader :value
	attr_accessor :neighbors

	def initialize(value)
		super
		@neighbors = []
	end
end
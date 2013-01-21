require_relative "piece.rb"

class Board
	def initialize
		@board = Array.new(4) { Array.new(4) { nil } }
		@emptypiece = EmptyPiece.new(0)
	end

	def move
		until has_won?
			print_board

			row, col = get_move

			puts "Can't move that piece" unless execute(row, col)
		end

		puts "You win!"

		print_board
	end

	def build_board
		pieces = []
		(1..15).each do |num|
			pieces << Piece.new(num)
		end
		
		pieces << @emptypiece
		pieces.reverse!

		@board.each_with_index do |row, i1|
			row.each_with_index do |col, i2|
				@board[i1][i2] = pieces.pop
			end
		end

		@emptypiece.neighbors = get_neighbors(find_zero)
	end

	def shuffle
		2000.times do
			row = rand(4)
			col = rand(4)

			execute(row, col)
		end
	end

	private
	
	def execute(row, col)
		if valid?([row, col])
			erow, ecol = find_zero
			@board[row][col], @board[erow][ecol] =
			@board[erow][ecol], @board[row][col]

			@emptypiece.neighbors = get_neighbors(find_zero)
			true
		else
			false
		end
	end

	def has_won?
		values = []

		@board.each_with_index do |row, i1|
			row.each_with_index do |col, i2|
				values << @board[i1][i2].value
			end
		end

		values == (1..15).to_a + [0]
	end

	def print_board
		@board.each_with_index do |row, i1|
			row.each_with_index do |col, i2|
				val = @board[i1][i2].value
				print '|'
				print ' ' if val < 10
				val = ' ' if val == 0
				print " #{val} "
			end
			print "|"
			puts
		end
	end


	def find_zero
		@board.each_with_index do |row, i1|
			row.each_with_index do |col, i2|
				return [i1,i2] if @board[i1][i2].is_a?(EmptyPiece)
			end
		end
	end

	def get_neighbors(coordinates)
		row, col = coordinates

		neighbors = []
		[[1,0],[-1,0],[0,1],[0,-1]].each do |pos|
			if ((0..3).include?(row+pos[0]) && (0..3).include?(col+pos[1]))
				neighbors << @board[row+pos[0]][col+pos[1]]
			end
		end

		neighbors
	end

	def valid?(coordinates)
		row, col = coordinates

		return @emptypiece.neighbors.include?(@board[row][col])
	end

	def get_move
		print "Move: > "
		number = gets.chomp.to_i

		raise ArgumentError unless (1..15).include?(number)

		# scan the board for the piece in question, and return its location
		@board.each_with_index do |row, i1|
			row.each_with_index do |col, i2|
				return [i1, i2] if @board[i1][i2].value == number
			end
		end
	end

end
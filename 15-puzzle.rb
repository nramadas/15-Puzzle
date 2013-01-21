#!/usr/bin/env ruby

require_relative 'lib/board.rb'
require_relative 'lib/piece.rb'

class Game
	def initialize
		@board = Board.new
	end
	
	def play
		@board.build_board
		@board.shuffle
		@board.move
	end
end

if __FILE__ == $PROGRAM_NAME
	game = Game.new
	game.play
end
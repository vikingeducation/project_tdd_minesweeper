require_relative('board.rb')
require_relative('player.rb')
require_relative('square.rb')

class Minesweeper
	def initialize(size = 10, num_mines = 9) # Optional paramaters w/ defaults
		@board = Board.new(size, num_mines)
		@player = Player.new(size)
	end

	# Let's play the game!
	def play
		#@player.get

	end
end
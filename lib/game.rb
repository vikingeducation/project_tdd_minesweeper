	# MINESWEEPER GAME
		# VICTORY?
			# ALL MINES MARKED
			# ALL SQUARES REVEALED/CLEARED
		# LOSS
			# MINE REVEALED
require_relative 'board'
require_relative 'player'
require_relative 'render'

class Game


	def initialize( difficulty = nil )

		@board = Board.new
		@player = Player.new
		@render = Render.new

	end


	def play

		loop do

			system 'clear'

			@render.render_board( @board.display_board )

			@player.get_move



		end


	end





end

game = Game.new
game.play
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

			@render.render_flags( @board.flags )
			@render.render_board( @board.board )

			until @board.valid_coordinates?( @player.get_coordinates )
				@player.get_coordinates
			end

			@board.check



		end


	end



	def player_choice( menu_selection )

		if ( 1..3 ) === menu_selection

			return @player.get_coordinates

		else

			exit

		end


	end




end

game = Game.new
game.play
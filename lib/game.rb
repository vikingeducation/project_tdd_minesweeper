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

		@board.generate_boards

		loop do

			@render.render_flags( @board.flags )
			@render.render_board( @board.display_board )

			until @board.valid_coordinates?( @player.get_coordinates )

				Render.render_message("Enter valid coordinates")

			end

			player_choice( @player.get_move )

		end


	end



	def player_choice( menu_selection )

		case menu_selection

		when 1

			check_for_mine
			@board.reveal_square


		when 2

			@board.place_flag
			win if @board.check_victory

		when 3

			@board.remove_flag

		when 4

			exit

		end


	end



	def check_for_mine

		loss if @board.check_for_mine

	end


	def win

		Render.render_message( %q(You Win!) )

		@render.render_board( @board.board )

		play_again

	end





	def play_again

		input = ""

		until input == 'Y' || input == 'N'

			Render.render_message( %q(Play Again? Y or N))

			input = gets.strip.upcase

		end

		input == 'Y' ? new_game : exit

	end




	def new_game

		game = Game.new
		game.play

	end




	def loss

		Render.render_message( %q(You Lose!) )

		@render.render_board( @board.board )

		play_again

	end

end

game = Game.new
game.play

require_relative 'board'
require_relative 'player'
require 'colorize'

class MineSweeper

	attr_reader :board, :player

	def initialize
		@board = Board.new
		@player = Player.new
	end

	def start
		@board.generate_map
		@board.render
	end

	def play
		start
		game_lost = false
		game_won = false
		flag_remainig = @board.mine_count
		loop do
			puts "Flags remaining are #{flag_remainig}\n".blue
			commands = @player.get_command(@board.rows, @board.cols)
			break if commands[0] == "quit"
			if commands[0] == "open"
				game_lost = @board.execute_open(commands[1].to_i, commands[2].to_i)
				break if game_lost
			end
			if commands[0] == "flag"
				flag_placed = @board.execute_flag(commands[1].to_i, commands[2].to_i)
				flag_remainig -= 1 if flag_placed
			end
			if commands[0] == "deflag"
				flag_removed = @board.execute_deflag(commands[1].to_i, commands[2].to_i)
				flag_remainig += 1 if flag_removed
			end
			game_won = @board.check_win
			break if game_won
			@board.render
		end	
		if game_lost
			puts "\n You opened a mine!!!! GAME LOST\n\n".red
		elsif game_won
			puts "\n You guessed all mines!!!! GAME WON\n\n".green
			@board.flip_all
		end
		@board.render
	end

end

#game = MineSweeper.new
#game.play
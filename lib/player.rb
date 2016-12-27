require 'colorize'

class Player

	def initialize 

	end

	def get_command(max_row, max_col)
		commands = []
		user_input = ''
		loop do
			puts "Enter next command".blue
			user_input = gets.chomp
			commands = user_input.split
			break if 	( 	
							quit_received(commands[0])			||
							(
								commands.size == 3							 &&
								good_command_received(commands[0])  		 && 
								good_row_received(commands[1].to_i, max_row) && 
								good_col_received(commands[2].to_i, max_col)
							)
						)
		end
		commands
	end

	private

	def quit_received(command)
		command == 'quit'
	end

	def good_command_received(command)
		command == 'open' || command == 'flag' || command == 'deflag'
	end

	def good_row_received(row, max_row)
		row >= 0 && row < max_row + 1
	end

	def good_col_received(col, max_col)
		col >= 0 && col < max_col + 1
	end

end
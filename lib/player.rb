# Class for handling interactions with
# the player.

class Player
	def initialize(size)
		@size = size
	end

	def get_move_type(error_message = nil)
		puts "#{error_message}" unless error_message.nil?
		puts "Enter 1 to add/remove a flag"
		puts "Enter 2 to clear a square"
		input = gets.chomp
		if valid_move_type?(input.to_i)
			input.to_i
		else
			false
		end
	end

	# Returns true if the input is 1 or 2
	def valid_move_type?(input)
		(input == 1 || input == 2) ? true : false
	end

	# Return false if coordinates aren't valid 
	def get_coordinates(error_message = nil)
		puts "#{error_message}" unless error_message.nil?
		puts "Enter the square's coordinates"
		puts "comma separated. E.G. \"1,1\""
		input = gets.chomp
		if valid_coordinates(input.split(',').map(&:to_i))
			input.split(',').map(&:to_i)
		else
			false
		end
	end

	def valid_coordinates(coords)
		result = false # We want to assume false at first
		if coords.length == 2
			if coords.all?{|coord| coord >= 1 && coord <= @size }
				result = true
			end
		end
		result
	end
end
require 'byebug'

class GameValidation < Mousevc::Validation
	def initialize(model)
		@model = model
	end

	def valid_clear?(x, y)
		is_valid_clear = coerce_bool @model.game.player.not_cleared?(x.to_i - 1, y.to_i - 1)
		unless is_valid_clear
			@error = "Error, square is already cleared at: #{x},#{y}"
		end
		is_valid_clear
	end

	def player_has_flags?
		player_has_flags = coerce_bool (@model.game.player.flags > 0)
		unless player_has_flags
			@error = "Error, you do not have any flags left"
		end
		player_has_flags
	end

	def valid_move?(value)
		is_valid_move = false
		if valid_format?(value)
			type = value.split(' ')[0]
			coordinates = value.split(' ')[1].split(',')
			x, y = coordinates[0], coordinates[1]
			if valid_coordinates?(x, y)
				is_valid_move = valid_clear?(x, y)
				if type == 'f'
					is_valid_move = player_has_flags?
				end
			end
		end
		is_valid_move
	end

	def valid_format?(value)
		is_valid_format = coerce_bool (value =~ /^[fc] \d+,\d+$/)
		unless is_valid_format
			@error = "Error, expected move in form [type] [x],[y], got: #{value}"
		end
		is_valid_format
	end

	def valid_coordinates?(x, y)
		valid_coordinates = (1..10).to_a
		are_valid_coordinates = coerce_bool (
			valid_coordinates.include?(x.to_i) &&
			valid_coordinates.include?(y.to_i)
		)
		unless are_valid_coordinates
			@error = "Error, x and y must both be between 1 and 10, got: #{x},#{y}"
		end
		are_valid_coordinates
	end
end
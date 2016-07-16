require 'pry'
	# PLAYER
		# @FLAGS
		# SELECT SQUARE
		# PLACE FLAG
		# QUIT GAME


class Player


	def get_move

		move = 0

		# must choose one of menu options for move
		until ( 1..4 ).include?( move )

			Render.prompt_for_move
			move = gets.strip.to_i

		end

		return move

	end


	def get_coordinates

		puts "Please enter coords"

		return coords = gets.strip.split(",").map! { |x| x.strip.to_i }


	end





end
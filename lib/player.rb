require_relative 'board.rb'

class Player

	attr_accessor :choice, :kind

	def initialize
		@choice = nil
		@kind = nil
	end

	def choose_coords
		puts "Please enter coordinates"
		@choice = eval(gets.chomp)
	end

	def move_kind
		puts "Do you want to flag or reveal that square?"
		@kind = gets.chomp
	end

end
require_relative 'minefield.rb'

class Player < Minefield
	attr_accessor :flags

	def initialize(options={})
		super(options)
		@flags = options[:flags] || 9
	end

	def flag(x, y)
		if @state[y][x] == 'F'
			@state[y][x] = 0
			@flags += 1
		else
			@state[y][x] = 'F'
			@flags -= 1
		end
	end

	def clear(x, y)
		@flags += 1 if flagged?(x, y)
		@state[y][x] = 'C'
	end

	def each_cleared
		@state.each_with_index do |row, y|
			row.each_with_index do |square, x|
				yield(x, y) if square == 'C'
			end
		end
	end

	def flagged?(x, y)
		@state[y][x] == 'F'
	end

	def not_flagged?(x, y)
		@state[y][x] != 'F'
	end

	def cleared?(x, y)
		!!(@state[y][x].to_s =~ /[\-1-9]/)
	end

	def not_cleared?(x, y)
		@state[y][x] == 0
	end
end
require_relative 'game_validation.rb'
require_relative 'minesweeper/game.rb'

class GameModel < Mousevc::Model
	attr_accessor :game

	def initialize
		super(:validation => GameValidation.new(self))
		clear
	end

	def clear
		@game = Game.new(:debug => true)
	end

	def move(value)
		raise "Not a string" unless value.is_a?(String)
		valid_move = @validation.valid_move?(value)
		if valid_move
			values = value.split(' ')
			type = values[0]
			x = values[1].split(',')[0]
			y = values[1].split(',')[1]
			x = x.to_i - 1
			y = y.to_i - 1
			@game.move(type, x, y)
		end
		valid_move
	end

	def flags
		@game.player.flags
	end

	def to_s
		@game.to_s
	end

	def cheat
		@game.cheat!
	end

	def boom
		@game.boom!
	end

	def flag
		[
			'f 1,1',
			'f 1,2',
			'f 1,3',
			'f 1,4',
			'f 1,5',
			'f 1,6',
			'f 1,7',
			'f 1,8',
			'f 1,9'
		].each {|v| move(v)}
	end

	def win?
		@game.win?
	end

	def lose?
		@game.lose?
	end
end
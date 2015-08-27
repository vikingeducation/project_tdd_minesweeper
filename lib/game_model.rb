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
		@game.player.flags > 0 ? @game.player.flags : "No more flags".colorize(:red)
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

	def win?
		@game.win?
	end

	def lose?
		@game.lose?
	end

	def flags
		@game.player.flags
	end
end
require_relative 'board.rb'
require_relative 'player.rb'

class Game
	attr_accessor :player, :board, :debug

	def initialize(options={})
		@debug = options[:debug] || false
		@player = Player.new(:state => options[:player]) || Player.new
		@board = Board.new(:state => options[:board]) || Board.new
	end

	def to_s
		str = @player.to_s
		str = [
			'---- Board ----'.center(43),
			@board.to_s,
			'---- Player ----'.center(43),
			@player.to_s
		].join("\n") if @debug
		str
	end

	def move(type, x, y)
		@player.flag(x, y) if type == 'f'
		clear(x, y) if type == 'c'
	end

	def cheat!
		@board.non_mine_coordinates.each do |c|
			x = c[1]
			y = c[0]
			clear_square(x, y)
		end
		@player.flags = 0
		@board.mine_coordinates.each do |c|
			x = c[1]
			y = c[0]
			@player.state[y][x] = 'F'
		end
	end

	def boom!
		@board.mine_coordinates.each do |c|
			x = c[1]
			y = c[0]
			@player.state[y][x] = @board.state[y][x]
		end
	end

	def lose?
		b = @board.normalize
			.gsub(/[^M]/, ' ')
			.gsub(/M/, 'x')
		p = @player.normalize
			.gsub(/[^M]/, ' ')
			.gsub(/M/, 'x')
		p == b
	end

	def win?
		b = @board.normalize
			.gsub(/[^M]/, ' ')
			.gsub(/M/, 'x')
		p = @player.normalize
			.gsub(/[\-1-9]/, ' ')
			.gsub(/F/, 'x')
		p == b
	end

	private
		def clear(x, y)
			if @board.mine?(x, y)
				boom!
			else
				@board.each_clearable(x, y) do |x, y|
					@player.clear(x, y)
				end
				@player.each_cleared do |x, y|
					clear_square(x, y)
				end
			end
		end

		def clear_square(x, y)
			@player.state[y][x] = @board.not_near_mine?(x, y) ? '-' : @board.state[y][x]
		end
end
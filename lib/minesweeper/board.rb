require_relative 'minefield.rb'

class Board < Minefield
	attr_accessor :mines

	def initialize(options={})
		super(options)
		@mines = options[:mines] || 9
		self.state = options[:state] || random_state
	end

	def select_coordinates
		coordinates = []
		@state.each_with_index do |row, y|
			row.each_with_index do |square, x|
				coordinates << [y, x] if yield(x, y)
			end
		end
		coordinates
	end

	def non_mine_coordinates
		select_coordinates {|x, y| not_mine?(x, y)}
	end

	def mine_coordinates
		select_coordinates {|x, y| mine?(x, y)}
	end

	def each_clearable(x, y)
		clearables(x, y).each do |c|
			x = c[1]
			y = c[0]
			yield(x, y)
		end
	end

	def clearables(x, y)
		q = []
		r_clearables = lambda do |x, y|
			coordinates = [y, x]
			unless q.include?(coordinates)
				q << coordinates
				unless near_mine?(x, y)
					each_adjacent(x, y) do |x, y|
						r_clearables.call(x, y) if in_bounds?(x, y)
					end
				end
			end
		end
		r_clearables.call(x, y)
		q
	end

	def mine?(x, y)
		@state[y][x] == 'M'
	end

	def not_mine?(x, y)
		@state[y][x] != 'M'
	end

	def near_mine?(x, y)
		@state[y][x] > 0
	end

	def not_near_mine?(x, y)
		@state[y][x] == 0
	end

	private
		def random_state
			@state = blank_state
			place_mines
			place_proximities
			@state
		end

		def place_mines
			squares = []
			@size.times do |i|
				@size.times do |j|
					squares << [i, j]
				end
			end
			@mines.times do
				coordinates = squares.shuffle!.pop
				x = coordinates[0]
				y = coordinates[1]
				@state[y][x] = 'M'
			end
		end

		def place_proximities
			@state.each_with_index do |row, y|
				row.each_with_index do |square, x|
					if square == 'M'
						each_adjacent(x, y) do |x, y|
							increment(x, y)
						end
					end
				end
			end
		end

		def increment(x, y)
			@state[y][x] += 1 if can_increment?(x, y)
		end

		def can_increment?(x, y)
			(in_bounds?(x, y) && not_mine?(x, y))
		end
end
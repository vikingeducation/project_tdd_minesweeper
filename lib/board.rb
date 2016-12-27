require_relative "cell"


class Board

	attr_reader :board_array, :mine_count, :rows, :cols

	def initialize(rows = 10, cols = 10)
		@board_array = Array.new(rows) { Array.new(cols) }
		rows.times do |x|
			cols.times do |y|
				@board_array[x][y] = Cell.new
			end
		end
		@mine_count = 0
		@rows = rows
		@cols = cols
	end

	def flip_all
		@rows.times do |x|
			@cols.times do |y|
				cell = @board_array[x][y]
				if cell.content != :mine
					cell.state = :opened
				end
			end
		end
	end

	def check_win
		mines_found = 0
		@rows.times do |x|
			@cols.times do |y|
				cell = @board_array[x][y]
				if cell.content == :mine && cell.state == :flagged
					mines_found += 1
				end
			end
		end
		true if mines_found == @mine_count
	end

	def render
		puts '###################################################'
		puts "    0    1    2    3    4    5    6    7    8    9"
		puts
		@board_array.each_with_index do |row, index|
			print "#{index} "
			row.each do |cell|
				cell.render
			end
			puts
			puts
		end
		puts '###################################################'
	end

	def execute_open(row, col)
		cell = @board_array[row][col]
		if cell.state == :closed
			cell.state = :opened
			if cell.content == :empty
				blow_cell(row, col)
			end
			if cell.content == :mine
				return true
			end
		end
		false
	end

	def blow_cell(row, col)
		blow_cell(row, col-1) if blow_left(row, col-1)
		blow_cell(row, col+1) if blow_right(row, col+1)
		blow_cell(row-1, col) if blow_top(row-1, col)
		blow_cell(row+1, col) if blow_bottom(row+1, col)
	end

	def blow_left(row, col)
		if col == -1
			return false
		end
		cell = @board_array[row][col]
		if (cell.content != :empty || cell.state != :closed)
			return false
		end
		cell.state = :opened
		true
	end

	def blow_right(row, col)
		if col == @cols
			return false 
		end
		cell = @board_array[row][col]
		if (cell.content != :empty || cell.state != :closed)
			return false 
		end
		cell.state = :opened
		true
	end

	def blow_top(row, col)
		if row == -1
			return false 
		end
		cell = @board_array[row][col]
		if (cell.content != :empty || cell.state != :closed)
			return false
		end
		cell.state = :opened
		true
	end

	def blow_bottom(row, col)
		if row == @rows
			return false 
		end
		cell = @board_array[row][col]
		if (cell.content != :empty || cell.state != :closed)
			return false 
		end
		cell.state = :opened
		true
	end

	def execute_flag(row, col)
		cell = @board_array[row][col]
		if cell.state == :closed
			cell.state = :flagged
			return true
		end
		false
	end

	def execute_deflag(row, col)
		cell = @board_array[row][col]
		if cell.state == :flagged
			cell.state = :closed
			return true
		end
		false
	end

	def generate_map
		generate_mines
		@rows.times do |x|
			@cols.times do |y|
				cell = @board_array[x][y]
				if cell.content != :mine
					mines = get_adjucent_mines(x,y)
					mines == 0 ? cell.content = :empty : cell.content = mines.to_s.to_sym
				end
			end
		end
	end

	def generate_mines
		rng = Random.new(@rows * @cols)
		@board_array.each_with_index do |row, x|
			row.each_with_index do |item, y|
				cell = @board_array[x][y]
				place_mine(rng.rand*100) ? (cell.content = :mine
										  	@mine_count += 1)
										 : cell.content = :empty
			end
		end
	end

	def place_mine(rand_value)
		rand_value < 10
	end

	def get_adjucent_mines(row, col)
		mines_nearby = 0
		mines_nearby += get_mines_in_row_below(row, col)
		mines_nearby += get_mines_in_row_above(row, col)
		mines_nearby += get_mines_in_same_row(row,col)
		mines_nearby
	end

	private

	def get_mines_in_row_below(row, col)
		mines_below = 0
		if is_valid_row(row+1) && is_valid_col(col-1)
			mines_below += 1 if is_mine(row+1,col-1)
		end
		if is_valid_row(row+1) && is_valid_col(col  )
			mines_below += 1 if is_mine(row+1,col  )
		end
		if is_valid_row(row+1) && is_valid_col(col+1)
			mines_below += 1 if is_mine(row+1,col+1)
		end
		mines_below
	end

	def get_mines_in_row_above(row, col)
		mines_above = 0
		if is_valid_row(row-1) && is_valid_col(col-1)
			mines_above += 1 if is_mine(row-1,col-1)
		end
		if is_valid_row(row-1) && is_valid_col(col  )
			mines_above += 1 if is_mine(row-1,col  )
		end
		if is_valid_row(row-1) && is_valid_col(col+1)
			mines_above += 1 if is_mine(row-1,col+1)
		end
		mines_above
	end

	def get_mines_in_same_row(row, col)
		mines_besides = 0
		if is_valid_row(row  ) && is_valid_col(col-1)
				mines_besides += 1 if is_mine(row  ,col-1)
		end
		if is_valid_row(row  ) && is_valid_col(col+1)
			mines_besides += 1 if is_mine(row  ,col+1)
		end
		mines_besides
	end

	def is_valid_row(row)
		row > -1 && row < @rows
	end

	def is_valid_col(col)
		col > -1 && col < @cols
	end

	def is_mine(row,col)
		cell = @board_array[row][col]
		cell.nil? ? false : cell.is_mine
	end

end
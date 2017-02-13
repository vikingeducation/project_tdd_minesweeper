# Stores the different states of the board

require_relative 'mine'

class Board

  attr_reader :board_arr, :mine

  def initialize(board = nil)
    @board_arr = board || Array.new(10){Array.new(10)}
    @mine = Mine.new
  end

  def render(reveal_all = false)
    puts
    @board_arr.each do |row|
      row.each do |cell|
        # Dont display the position of the mines when rendering
        if (cell.nil?)
          print("-")  
        elsif (cell == "X" && reveal_all == false)
           print("-")
        else
          print(cell.to_s)
        end
      end
      puts
    end
    puts
  end

  def within_valid_coordinates?(coords)
    if (0..9).include?(coords[0]) && (0..9).include?(coords[1])
        true
    else
        puts "The chosen coordinates are not in the range of the board"
    end
  end

  def coordinates_available?(coords)
      if @board_arr[coords[0]][coords[1]].nil? || @board_arr[coords[0]][coords[1]] == "X"
          true
      else
          puts "Position already used"
      end
  end


  def full?
      @board_arr.all? do |row|
          row.none? {|x| x.nil?}
      end
  end

  def add_to_board(coords, marker)
    if location_valid?(coords)
      @board_arr[coords[0]][coords[1]] = marker
        true
    else
        false
    end
  end

  def location_valid?(coords)
    if within_valid_coordinates?(coords)
        coordinates_available?(coords)
    end
  end
  
  def add_mines_to_board(n)
    # Create random cell references for the mines
    @mine.create_mines(n)
    mines = @mine.mine_arr
    mines.each do |mine|
      add_to_board(mine, "X")
    end
  end

  def num_adj_mines(coords)
    mines = @mine.get_num_adj_mines(coords)
  end

   # Find coordinates for neighbouring cells that are definitely clear
  def update_clear_neighbours(cell)
    all_directions = [
      [-1, 1],  [0, 1],  [1, 1],
      [-1, 0],           [1, 0],
      [-1, -1], [0, -1], [1, -1]
    ]

    all_directions.each do |adj_cell|
      neighbour = [adj_cell[0] + cell[0], adj_cell[1] + cell[1]]
      next unless (0..8).include?(neighbour[0]) && (0..8).include?(neighbour[1])

      add_to_board(cell, "C")

      # unless @minefield.all_tiles[neighbor[0]][neighbor[1]].revealed
      #   reveal(neighbor)
      # end
    end
  end
end

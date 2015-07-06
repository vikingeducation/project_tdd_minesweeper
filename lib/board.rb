require_relative "tile.rb"

class Board

  attr_accessor :game_state
  attr_reader :height, :width

  def initialize(height = 10, width = 10, amount_mines = 9)

    @height = height
    @width = width
    @game_state = Array.new(height) {Array.new(width)}
    create_board
    generate_mines(amount_mines)
    get_tiles_mine_count

  end

  def create_board

    (0...@height).each do |x|
      (0...@width).each do |y|
        @game_state[x][y] = Tile.new(x, y)
      end
    end

  end

  def generate_mines(amount_needed)

    mines_generated = 0

    while mines_generated < amount_needed
      current_tile = @game_state[rand(0..9)][rand(0..9)]

      unless current_tile.is_mine
        current_tile.is_mine = true
        mines_generated += 1
      end

    end
  end

  def get_tiles_mine_count

    (0...@height).each do |x|
      (0...@width).each do |y|
        current_tile = @game_state[x][y]
        find_mines_nearby(current_tile)
      end
    end

  end

  def find_mines_nearby(tile)
    num_of_mines = 0

    neighbors = find_neighbors(tile)

    neighbors.each do |t|
      if t.is_mine
        num_of_mines += 1
      end
    end

    tile.mines_nearby = num_of_mines

  end

  def find_neighbors(tile)

    # We have to flatten first so we can access the objects inside the array shell
    @game_state.flatten.select do |t|
      t.x.between?(tile.x.-(1), tile.x.+(1)) &&
      t.y.between?(tile.y.-(1), tile.y.+(1)) &&
      t != tile
    end

  end

  def render

    system "clear"
    print "\n"

    puts "****** Current Board ******"
    print "\n"
    (@height-1).downto(0) do |y|
      print " #{y+1}  |  " if y < 9
      print " #{y+1} |  " if y >= 9
      (0...@width).each do |x|
        current_tile = @game_state[x][y]
        if current_tile.is_flag
          print "F "
        elsif !current_tile.is_cleared
          print "- "
        elsif current_tile.is_mine
          print "* "
        else
          print "#{current_tile.mines_nearby} "
        end
      end
      print "\n"
    end
    puts "    |"
    puts "    |__1_2_3_4_5_6_7_8_9_10__"
    print "\n"
  end

  def clear_nearby(tile)

    neighbors = find_direct_neighbors(tile)

    neighbors.each do |t|

      unless t.is_cleared
        t.is_cleared = true
        clear_nearby(t) if t.mines_nearby == 0
      end

    end

  end

  def find_direct_neighbors(tile)

    @game_state.flatten.select do |t|
      (t.x == tile.x.+(1) && t.y == tile.y) ||
      (t.x == tile.x.-(1) && t.y == tile.y) ||
      (t.x == tile.x && t.y == tile.y.+(1)) ||
      (t.x == tile.x && t.y == tile.y.-(1))
    end

  end


  def reveal_mines

    (0...@height).each do |x|
      (0...@width).each do |y|
        current_tile = @game_state[x][y]
        current_tile.is_cleared = true if current_tile.is_mine
      end
    end
    render

  end

end
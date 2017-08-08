require './lib/tile.rb'

class Board
  attr_reader :x_len, :y_len, :mines, :field, :tiles

  def initialize(x_len, y_len, mines)
    @field = []
    @x_len = x_len
    @y_len = y_len
    @mines = mines
    @tiles = []
    build_tiles
    randomize_mines
  end

  ##
  # TODO: Line 30 isn't working as expected to create a new line
  # Potentially change string to array or change string build method
  # "Bombs" are showing in board on first print. This should change.

  def print_board
    board = ''
    @y_len.times do |y|
      @x_len.times do |x|
        if @tiles[y][x].mine
          board << 'B'
        elsif !@tiles[y][x].revealed
          board << '?'
        else
          board << 'r'
        end
      end
      board << "\n"
    end
   p board
  end

  def click(x, y)
    @tiles[y][x].click

    if @tiles[y][x].mine
      return 'mine'
    elsif @tiles[y][x].revealed
      return 'revealed'
    else
      fail 'Some other weird shit happened'
    end
  end

  private

  def build_tiles
    @tiles = Array.new(@y_len) { |y| Array.new(@x_len) { |x| Tile.new(x, y) } }
  end

  def randomize_mines
    reset_all_mines
    while @field.count < @mines do
      x = rand(@x_len)
      y = rand(@y_len)

      if !@field.include?(@tiles[y][x])
        @tiles[y][x].mine = true
        @field << @tiles[y][x]
      end
    end
  end

  def reset_all_mines
    @field.each { |tile| tile.mine = false }
    @field.clear
  end

end

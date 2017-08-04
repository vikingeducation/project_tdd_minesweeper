require './lib/tile.rb'

class Board
  attr_reader :x_len, :y_len, :mines, :field, :tiles

  def initialize(x_len, y_len, mines)
    @field = []
    @x_len = x_len
    @y_len = y_len
    @mines = mines
    build_tiles
    randomize_mines
  end

  def print_board
    board = ''
    @y_len.times do |y|
      @x_len.times do |x|
        if @tiles[y][x].mine
          board << 'B'
        elsif !@tiles[y][x].revealed
          board << '?'
        elsif @tiles[y][x].flagged
          board << 'f'
        else
          board << 'r'
        end
      end
      board << "\n"
    end
    board
  end

  def click(x, y)

    if @tiles[y][x].mine
      return 'mine'
    elsif @tiles[y][x].revealed
      return 'revealed'
    else
      fail 'Some other weird shit happened'
    end

    @tiles[y][x].click
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

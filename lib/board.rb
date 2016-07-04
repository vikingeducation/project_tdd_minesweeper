require 'pry'
require_relative '../lib/square.rb'
class Board
  attr_accessor :matrix, :remaining_flags, :size, :cursor, :make_mine
  def initialize(size=10, mines=9)
    @size = size
    @cursor = [4, 4]
    @matrix = []
    size.times { @matrix << Array.new(size) { |_i| Square.new } }
    index_squares
    @remaining_flags = mines
    random_squares.each { |i, j| @matrix[i][j].make_mine }
  end

  def render(show_mines = false)
    system("clear")
    puts "Welcome to Command line Minesweeper!"
    puts "_______" * 10
    puts "Remaining Flags : #{remaining_flags}"
    puts "_______" * 10
    (0..@size - 1).each do |x|
      (0..@size - 1).each do |y|
        [x, y] == @cursor ? print("  <") : print("   ")
        print @matrix[x][y].to_s(show_mines)
        [x, y] == @cursor ? print(">  ") : print("   ")
      end
      puts
    end
    puts "_______" * 10
    puts "Press arrow keys to navigate within the board"
    puts "Press [c] to clear , [f] to flag, [u] to unflag"
    puts "_______" * 10
  end

  def random_squares(size = 10)
    rand_squares = []
    until rand_squares.size == 9
      sqr = [rand(0..size - 1),rand(0..size-1)]
      rand_squares << sqr if !rand_squares.include?(sqr)
    end
    rand_squares
  end

  def clear_square(coordinates = cursor)
    i, j = coordinates
    square = @matrix[i][j]
    if square.clear
      square.update_mine_count neighboring_mines(coordinates)
      self.each_neighbor(coordinates) do |n, coord|
        n.clear
        n.update_mine_count neighboring_mines(coord)
      end
    end
  end

  def auto_clear_squares
    extend(Enumerable)
    p self.select { |sq| sq.neighboring_mines_zeros? && !sq.auto_cleared? }.count
    while self.count { |sq| sq.neighboring_mines_zeros? && !sq.auto_cleared? } != 0
      self.select { |sq| sq.neighboring_mines_zeros? && !sq.auto_cleared? }.each do |z|
        z.auto_clear
        clear_square(z.coordinates)
      end
    end
  end

  def r_clear_square(i, j, memo)
    puts "#{i}, #{j}"
    return if @matrix[i][j].clear == nil
    return if i < 0 || i >= size || j < 0 || j >= size
    return  if memo.include?([i,j])
    memo << [i,j]
    r_clear_square(i-1, j, memo)
    r_clear_square(i+1, j, memo)
    r_clear_square(i, j-1, memo)
    r_clear_square(i, j+1, memo)
    r_clear_square(i-1, j-1, memo)
    r_clear_square(i-1, j+1, memo)
    r_clear_square(i+1, j-1, memo)
    r_clear_square(i+1, j+1, memo)
  end

  def flag_square
    if @remaining_flags > 0
      @remaining_flags -= 1 if cur_square.flag
    end
  end

  def unflag_square
    @remaining_flags += 1 if cur_square.unflag
  end

  def neighboring_mines(coordinates = cursor)
    mines = 0
    self.each_neighbor(coordinates) { |n, _coordinates| n.mine? ? mines += 1 : nil }
    mines
  end

  def cur_square
    i, j = cursor
    @matrix[i][j]
  end

  def update(action)
    case action
    when :flag
      flag_square
    when :unflag
      unflag_square
    when :clear
      return :gameover if !clear_square
    else
      update_cursor(action)
    end
  end

  def update_cursor(direction)
    case direction
    when :right
     @cursor[1] = (@cursor[1] + 1) % size
    when :left
     @cursor[1] = (@cursor[1] - 1) % size
    when :up
     @cursor[0] = (@cursor[0] - 1) % size
    when :down
     @cursor[0] = (@cursor[0] + 1) % size
    else
      raise "Invalid direction"
    end
  end

  def winner?
    extend(Enumerable)
    num_cleared = self.count { |sq| sq.cleared? }
    num_mines   = self.count { |sq| sq.mine? }
    num_flaged = self.count { |sq| sq.flaged? }
    num_mines == num_flaged && num_cleared + num_mines == size * size
  end

  def index_squares
    i = 0
    while i < @matrix.count
      j = 0
      while j < @matrix.count
        @matrix[i][j].coordinates = [i,j]
        j += 1
      end
      i += 1
    end
    @matrix
  end

  def each
    i = 0
    while i < @matrix.count
      j = 0
      while j < @matrix.count
        yield @matrix[i][j]
        j += 1
      end
      i += 1
    end
    @matrix
  end

  def each_neighbor(coordinates = cursor)
    delta = { up: [-1, 0], down: [1, 0], left: [0,-1], right: [0, 1],
              upleft: [-1, -1], upright: [-1, 1], downleft: [1, -1], downright: [1, 1]}
    delta.each_value do |x,y|
      i, j = coordinates
      i += x
      j += y
      if i >= 0 && i < size && j >= 0 && j < size
        yield(@matrix[i][j], [i, j])
      end
    end
  end

end

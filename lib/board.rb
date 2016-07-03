require 'pry'
class Board
  attr_accessor :matrix, :remaining_flags, :size, :cursor, :make_mine
  def initialize(size=10, mines=9)
    @size = size
    @cursor = [4,4]
    @matrix = []
    size.times { @matrix << Array.new(size) { |i| Square.new } }
    @remaining_flags = mines
    random_squares.each { |i,j| @matrix[i][j].make_mine }
  end

  def render
    system("clear")
    puts "_______" * 10
    puts "Remaining Flags : #{remaining_flags}"
    puts "_______" * 10
    (0..@size-1).each do |x|
      (0..@size-1).each do |y|
        [x,y] == @cursor ? print("  <") : print("   ")
        print @matrix[x][y].to_s
        [x,y] == @cursor ? print(">  ") : print("   ")
      end
      puts
    end
    puts "_______" * 10
    puts "Press arrow keys to navigate within the board"
    puts "Press [c] to clear , [f] to flag"
    puts "_______" * 10
  end

  def random_squares(size = 10)
    rand_squares = []
    until rand_squares.size == 9
      sqr = [rand(0..size-1),rand(0..size-1)]
      rand_squares << sqr if !rand_squares.include?(sqr)
    end
    rand_squares
  end

  def clear_square
    if cur_square.clear
      cur_square.update_mine_count neighboring_mines
      self.each_neighbor do |n, coordinates|
        n.clear
        n.update_mine_count neighboring_mines(coordinates)
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
    cur_square.flag
  end

  def unflag_square
    cur_square.unflag
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

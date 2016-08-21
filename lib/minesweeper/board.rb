module Minesweeper
  # Initializes board and handles board logic
  class Board
    attr_reader :view
    def initialize(size = 10, mines = 15, grid = nil, map = nil)
      @size = size
      @mines = mines
      @mine_map = map || mine_map
      @grid = grid || build_grid
      @view = Minesweeper::View.new
      @revealed = 0
      @boom = false
      @cursor = [0, 0]
      place_mines
    end

    def build_grid
      grid = []
      (0..@size - 1).each do |x|
        grid << []
        (0..@size - 1).each do |y|
          grid[x] << Minesweeper::Square.new([x, y], @mine_map)
        end
      end
      grid
    end

    def place_mines
      @mine_map.each do |coord|
        @grid[coord[0]][coord[1]].add_mine
      end
    end

    def place_flag(input)
      @grid[input[0]][input[1]].change_flag
    end

    def reveal_square(input)
      x = input[0]
      y = input[1]
      return if @grid[x][y].showing
      @grid[x][y].reveal ? @revealed += 1 : @boom = true
      return if @grid[x][y].surround >= 1
      surrounding_squares([x, y]).each do |coord|
        reveal_square([coord[0], coord[1]])
      end
    end

    def complete?
      @size**2 - @mines <= @revealed
    end

    def boom?
      @boom
    end

    def receive_input(input)
      options = { flag: method(:place_flag), reveal: method(:reveal_square), quit: method(:exit) }
      if options.include?(input)
        exit if input == :quit
        options[input].call(@cursor)
      else
        case input
        when :up
          @cursor[0] = (@cursor[0] - 1) % @size
        when :down
          @cursor[0] = (@cursor[0] + 1) % @size
        when :right
          @cursor[1] = (@cursor[1] + 1) % @size
        when :left
          @cursor[1] = (@cursor[1] - 1) % @size
        else
          raise 'invalid input'
        end
      end
    end

    def render
      show_all if boom? || complete?
      @view.render_board(@grid, @cursor)
    end

    private

    def surrounding_squares(input)
      arr = []
      x = input[0]
      y = input[1]
      (x - 1..x + 1).each do |i|
        (y - 1..y + 1).each do |j|
          arr << [i, j] if i.between?(0, @size - 1) && j.between?(0, @size - 1)
        end
      end
      arr - [input]
    end

    def show_all
      @grid.each do |col|
        col.each(&:reveal)
      end
    end

    def mine_map
      map = []
      coord = []
      (0..@size - 1).each do |x|
        (0..@size - 1).each { |y| coord << [x, y] }
      end
      @mines.times do
        map << coord.delete(coord.sample)
      end
      map
    end
  end
end

class Board
  attr_reader :grid, :mines, :flags

  def initialize(size: 10, mines: 9)
    @grid = Array.new(size) { Array.new(size) }
    @mines = mines
    @flags = mines
  end

  def populate_board(given_coord)
    unplaced_mines = @mines
    until unplaced_mines == 0
      coord = random_coord
      next if coord == given_coord
      place_mine(coord)
      unplaced_mines -= 1
    end
  end

  def render

  end

  private

  def random_coord
    x = (0...@size).to_a.sample
    y = (0...@size).to_a.sample
    [x,y]
  end
end

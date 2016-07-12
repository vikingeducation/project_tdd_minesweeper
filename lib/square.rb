
class Square
  attr_reader :surround, :reveal, :flag, :mine
  def initialize(coord, map)
    @surround = set_surroundings(map)
    @showing = false
    @flag = false
    @mine = false
    @coord = coord
  end

  def change_flag
    @flag = !@flag
  end

  def add_mine
    @mine = true
  end

  def reveal
    @showing = true
  end

  def count_mines(map)
    x = @coord[0]
    y = @coord[1]
    mines = 0
    (x-1..x+1).each do |i|
      (y-1..y+1).each do |j|
        mines += 1 if map.include?([i,j])
    end
    # looks at surroundings and counts number of mines
  end

end

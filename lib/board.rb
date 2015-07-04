class Board
  attr_reader :field

  def initialize

    @field = Array.new(10) { Array.new(10) { 0 }  }
    count = 0
    used = []
    until count == 9
      current_row = rand(0..9)
      current_col = rand(0..9)
      current = [current_row, current_col]
      unless used.include?(current)
        @field[current_row][current_col] = "M"
        used << current
        count += 1
      end
    end

    @flag_count = 10

  end

  def clear_square(player_move)
  end

  def render

    render_board = []

  end

  def flag_count
    @flag_count
  end

  def decrease_flag_count
    @flag_count -= 1
  end

  def increase_flag_count
    @flag_count += 1
  end
end
  
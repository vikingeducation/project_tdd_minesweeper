class Board
  attr_reader :field

  def initialize(state=nil)

  # M == mine
  # 0 == nothing
  # 1-8 == hints
  # F == flag
  # O == flagged mine

    # The actual state
    # Mines
    # Hints "what number do we show when we reveal"
    @field = Array.new(10) { Array.new(10) { 0 }  }
    # What's drawn to the player
    # Revealed
    # Flagged
    #@display_board
    generate_mines
    @flag_count = 10

  end


  def generate_mines
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
  
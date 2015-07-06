class Board
  attr_accessor :field


  def initialize()
  
    @field = Array.new(10) { Array.new(10) {{:hint => 0, :flag => false, :mine => false, :revealed =>false}}  }

    generate_mines
    @flag_count = 10
    @game_over = false
  end

  def game_over?
    @game_over
  end

  def generate_mines
  count=0
    while count<9
      if @field[rand(0..9)][rand(0..9)][:mine] == false
        @field[rand(0..9)][rand(0..9)][:mine] = true  
        count += 1
      end 
    end
  end

  def flag(x,y)
    getsq(x,y)[:flag]=true
  end

  def clear(x,y)
    if getsq(x,y)[:mine]
      @game_over=true
    else
      getsq(x,y)[:revealed]=true
    end
  end
  def getsq(x,y)
   @field[x][y]
  end

  def clear_square(player_move)
  end

  def render

    #render_board = []

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
  
class Board
  attr_accessor :field, :size


  def initialize()
    @field = Array.new(10) { Array.new(10) {{:hint => 0, :flag => false, :mine => false, :revealed =>false}}  }
    @size = 10
    generate_mines
    @flag_count = 10
    @game_over = false
  end

  def game_over?
    @game_over
  end

  def win?

  end

  # How to generate hints
  # Take each square and count surrounding mines
  def generate_hints
    @field.each_with_index do |row, x|
      row.each_with_index do |h, y|
        getsq(x,y)[:hint] = get_nearby_mines(x,y)
      end
    end
  end

  def get_around(x, y)
    map = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,1],[1,0],[1,-1]]

    surrounding = []
    map.each do |val|
      if getsq(val[0] + x, val[1] + y)
        surrounding << getsq(val[0] + x,val[1] + y)
      end
    end
    return surrounding
  end

  def get_around_map(x, y)
    map = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,1],[1,0],[1,-1]]

    surrounding = []
    map.each do |val|
      if getsq(val[0] + x, val[1] + y)
        surrounding << [val[0] + x,val[1] + y]
      end
    end
    return surrounding
  end

  def get_nearby_mines(x,y)
    nearby = get_around(x, y)
    nearby.select {|sq| sq[:mine]}.length
  end


  def generate_mines
  count=0
    while count<9
      row = rand(0..9)
      col = rand(0..9)
      unless @field[col][row][:mine]
        @field[col][row][:mine] = true
        count += 1
      end
    end
  end

  def flag(x,y)
    if getsq(x,y)[:flag]
      getsq(x,y)[:flag]=false
      @flag_count += 1
    else
      unless flag_count == 0
        getsq(x,y)[:flag]=true
        @flag_count -= 1
      end
    end
  end

  # Clearing:
  # Clears current square, and also any obvious nearby squares,
  # and any obvious squares near those, and so on and so forth
  def clear(x,y)
    if getsq(x,y)[:mine]
      @game_over=true
    else
      reveal(x,y)
    end
  end

  # Get current square
  # Reveal it if not revealed
  # Get neighbors
  # Reveal neighbors
  def reveal(x, y)
    current_square = getsq(x, y)
    current_square[:revealed]=true unless current_square[:revealed]
    get_around_map(x, y).each do |coord|
      new_sq = getsq(coord[0], coord[1])
      return if new_sq[:revealed]

      if new_sq[:hint] == 0 || !new_sq[:mine]
        new_sq[:revealed]=true
        reveal(coord[0], coord[1])
      elsif !new_sq[:mine]
        new_sq[:revealed]=true
      end
    end

  end

  def getsq(x,y)
    unless x >= @size || x < 0 || y >= @size || y < 0
      return @field[x][y]
    else
      return nil
    end
  end

  def clear_square(player_move)
  end

  def render

    #render_board = []

  end

  def flag_count
    @flag_count
  end



  def increase_flag_count
    @flag_count += 1
  end
end
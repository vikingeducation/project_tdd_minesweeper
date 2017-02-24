class Game
  attr_accessor :app_state

  def initialize
    @app_state = {
      board: Array.new(10){ Array.new(10) },
      mines: 9,
      flags: [],
      mine_positions: [],
      flags_remaining: 9,
      valid_actions: [:C, :F],
      status: {}
    }
  end

  # ----------------------------------------------------------------------
  # app state
  # ----------------------------------------------------------------------

  def board
    app_state[:board]
  end

  def mines
    app_state[:mines]
  end

  def flags_remaining
    app_state[:flags_remaining]
  end

  def valid_actions
    app_state[:valid_actions]
  end

  def status
    app_state[:status]
  end

  # ----------------------------------------------------------------------
  # app state
  # ----------------------------------------------------------------------

  def within_board_limits(x, y)
    rows, cols = board.length, board[0].length
    (0...rows).include?(x) && (0...cols).include?(y)
  end

  def generate_mines
    rows, cols = board.length, board[0].length
    (0...mines).reduce([]) do |acc, i|
      x, y = rand(0...rows), rand(0...cols)
      acc << [x, y]
    end
  end

  def plant_mines!(mine_positions)
    mine_positions.each do |x, y|
      app_state[:mine_positions] << [x, y]
      board[x][y].nil? ? board[x][y] = {mine?: true} : board[x][y][:mine?] = true
    end
  end

  def render(msgs)
    # we preppend a \n for aesthetic reaons
    if msgs.is_a?(Array)
      msgs.each_with_index do |msg, i|
        puts if i == 0
        puts msg
      end
    else
      puts "\n#{msgs}"
    end
  end

  def render_board
    puts
    puts "Remaining flags: #{flags_remaining}"
    puts
    print "   "
    cols = board[0].length
    (1..cols).each{ |i| print " #{i} " }
    puts
    puts
    board.each_with_index do |row, row_i|
      # compensating spacing for two digit integer
      row_i+1 >= 10 ? print("#{row_i+1} ") : print("#{row_i+1}  ")
      row.each_with_index do |cell, col_i|
        if cell.nil?
          print " - "
        elsif flagged?(row_i, col_i) #cell[:flagged?]
          print " F "
        elsif mine?(row_i, col_i) #cell[:mine?]
          print " - "
        elsif cell[:count].zero?
          print "   "
        elsif (1..9).include?(cell[:count])
          print " #{cell[:count]} "
        end
      end
      print("  #{row_i+1}")
      puts
    end
    puts
    print "   "
    (1..cols).each{ |i| print " #{i} " }
  end

  def mine?(x, y)
    cell = board[x][y]
    if cell.nil?
      false
    else
      cell[:mine?] ? true : false
    end
  end

  def board_full?
    board.all? do |row|
      row.none?(&:nil?)
    end
  end

  def flagged?(x, y)
    cell = board[x][y]
    if cell.nil?
      false
    else
      cell[:flagged?] ? true : false
    end
  end

  def nearby_mine_count(x, y)
    (x-1..x+1).reduce(0) do |acc, x_|
      acc + (y-1..y+1).reduce(0) do |partial, y_|
        if !within_board_limits(x_, y_)
          partial
        elsif mine?(x_, y_)
          partial + 1
        else
          partial
        end
      end
    end
  end

  def clear_surrounding_squares!(x, y)
    rows, cols = board.length, board[0].length
    (x-1..x+1).each do |x_|
      (y-1..y+1).each do |y_|
        next if not within_board_limits(x_, y_)
        next if not board[x_][y_].nil?
        clear_square!(x_, y_)
      end
    end
  end

  def clear_square!(x, y)
    if mine?(x, y)
      app_state[:status] = {lose: "You've hit a bomb!\nGame over!"}
      false
    else
      nmc = nearby_mine_count(x, y)
      board[x][y] ? board[x][y][:count] = nmc : board[x][y] = {count: nmc}
      #board[x][y] = nmc
      clear_surrounding_squares!(x, y) if nmc.zero?
      true
    end
  end

  def place_flag!(x, y)
    if flags_remaining > 0 && (board[x][y].nil? || mine?(x, y))
      app_state[:flags] << [x, y]
      app_state[:flags_remaining] -= 1
      board[x][y] ? board[x][y][:flagged?] = true : board[x][y] = {flagged?: true}
      true
    else
      false
    end
  end

  def sanitize_move(input)
    action, x, y = input.split(" ").map{ |char| char.strip }
    action, x, y = action.upcase.to_sym, x.to_i - 1, y.to_i - 1
    rows, cols = board.length, board[0].length
    if (!valid_actions.include?(action) ||
        !(0...rows).include?(x)         ||
        !(0...cols).include?(y))
      puts "Please insert a valid input"
      player_input
    else
      [action, x, y]
    end
  end

  def player_input
    print("\nInsert your move > ")
    sanitize_move(gets)
  end

  def place_move!(input)
    action, x, y = input
    case action
    when :F
      place_flag!(x, y)
    when :C
      clear_square!(x, y)
    end
  end

  def win?
    if board_full?
      puts "You've won!\nCongratulations!"
      true
    end
  end

  def game_loop
    return if win?
    render_board
    place_move!(player_input)
    if status[:lose]
      render(status[:lose])
    else
      game_loop
    end
  end

  def instructions
    info = [
      "**** MineSweep ****",
      "Welcome to MineSweep",
      "On each turn choose the action and the axis you'd like to perform it on",
      "Valid actions are:",
      "Clear the square: c",
      "Flag a square: f",
      "You should provide first the action, followed by the x and y axis",
      "in the following form:",
      "c 5 5",
      "Have fun"
    ]
    render(info)
  end

  def play
    instructions
    plant_mines!(generate_mines)
    game_loop
  end

end

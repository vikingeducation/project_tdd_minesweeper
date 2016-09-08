class Player

  attr_reader :move

  def initialize(board)
    @move = []
    @board = board
  end

  def get_move
    puts "# Enter your desired move: "
    puts "# (in the format \'0,0\')"
    @move = gets.chomp.split(',').map(&:to_i)
    clear_flag?
  end

  def clear_flag?
    puts "Would you like to clear that space, or place a flag there? (c/f)"
    c_l = gets.chomp.downcase
    if c_l == 'c'
      @board.place_move(@move)
    elsif c_l == 'f'
      @board.place_flag(@move)
    else
      puts "Please enter your anser with a \'c\' or an \'f\'"
    end
  end

end
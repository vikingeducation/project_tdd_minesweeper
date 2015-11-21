class Player
  attr_reader :name, :board

  def initialize(board, name=nil)
    @name = name || get_name
    @board = board
  end

  def take_turn
    loop do
      type = ask_move_type
      if type == 'f'
        move = ask_turn('flag')
        if valid_format?(move)
          break if @board.place_flag(move)
        end
      else
        move = ask_turn('move')
        if valid_format?(move)
          break if @board.place_move(move)
        end
      end
    end
  end

  private

  def ask_move_type
    puts "\nTo place a flag, type 'f'. Type anything else to clear a square."
    print " > "
    gets.chomp.downcase
  end

  def get_name
    puts "Welcome to Minesweeper!  What is your name?"
    print " > "
    gets.chomp.capitalize
  end

  def ask_turn(type)
    puts "\nEnter your #{type} as row number, column number. For example: 4,5"
    print " > "
    gets.chomp.split(',').map{|i| i.to_i}
  end

  def valid_format?(move)
    if move.is_a?(Array) && move.size == 2 && move.all?{|i| i.is_a?(Integer)}
      true
    else
      puts "I'm sorry, I don't recognize that spot. Try again."
    end
  end

end
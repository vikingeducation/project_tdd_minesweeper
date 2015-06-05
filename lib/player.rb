class Player

  def initialize(board_width = 10, board_height = 10)
    @board_width = board_width
    @board_height = board_height

    @valid_commands = %w(clear flag)
    @valid_rows = (1..@board_height).to_a.map! { |number| number.to_s }
    @valid_columns = ("a".."z").to_a.take(@board_width)
  end


  def take_turn
    move = ""

    loop do
      move = parse_input(get_input)
      break if valid_input?(move)
    end

    translate(move)
  end


  def get_input
    puts "Enter your move below."
    puts "Specify your row and column with the number and letter shown."
    puts "Choose whether you'd like to 'flag' the square as a mine,"
    puts "or 'clear' the square to reveal it. Use spaces to separate"
    puts "each part, and order doesn't matter ('clear A 10' = '10 a clear')."
    print ">>> "
    gets.chomp
  end


  def parse_input(input)
    input.downcase.split(" ").uniq
  end


  def valid_input?(parsed_input)
    find_command?(parsed_input) && find_row?(parsed_input) && find_column?(parsed_input)
  end


  def find_command?(parsed_input)
    (parsed_input & @valid_commands).size == 1
  end


  def find_row?(parsed_input)
    (parsed_input & @valid_rows).size == 1
  end


  def find_column?(parsed_input)
    (parsed_input & @valid_columns).size == 1
  end


  def translate(parsed_input)
    final_input = {}

    final_input[:command] = (parsed_input & @valid_commands)[0]

    final_input[:row] = (parsed_input & @valid_rows)[0].to_i

    column_letter = (parsed_input & @valid_columns)[0]
    column_number = @valid_columns.index(column_letter) + 1
    final_input[:column] = column_number.to_i

    final_input
  end

end
class Player

  def initialize(board_width = 10, board_height = 10)
    @board_width = board_width
    @board_height = board_height
  end


  def take_turn
    #loop
      #move = parse_input(get_input)
      #break if valid_input?
    #end

    #return input
  end


  def get_input
    puts "Enter your move below."
    puts "Specify your row and column with the number and letter shown."
    puts "Choose whether you'd like to 'flag' the square as a mine,"
    puts "\tor 'clear' the square to reveal it. Use spaces to separate"
    puts "\teach part (example: clear A 10)."
    gets.chomp
  end


  def parse_input(input)
    input.downcase.split(" ")
  end


  def valid_input?(parsed_input)
    find_command? && find_row? && find_column?
  end


  def find_command?(parsed_input)
    valid_commands = %w(clear flag)
    (parsed_input & valid_commands).size == 1
  end


  def find_row?(parsed_input)
    valid_rows = (1..@board_height).to_a.map! { |number| number.to_s }
    (parsed_input & valid_rows).size == 1
  end


  def find_column?(parsed_input)
    valid_columns = ("A".."Z").to_a.take(@board_width)
    (parsed_input & valid_columns).size == 1
  end

end
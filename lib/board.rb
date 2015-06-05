require_relative 'square'

class Board
  attr_reader :victory, :defeat

  def initialize(height = 10, width = 10, number_of_mines = 9)
    @height = height
    @width = width
    @number_of_mines = number_of_mines
    @squares = []

    1.upto(width) do |x|
      1.upto(height) do |y|
        @squares << Square.new(x,y)
      end
    end

    @victory = @defeat = false
  end


  def row_status(row_number)
    row = []

    @squares.each do |square|
      row << square.status if square.y == row_number
    end

    row
  end


  def render_row(row)
    row.each { |square| print "#{square} " }
    print "\n"
  end


  def render_column_header
    header = {}
    letters = ("A".."Z").to_a

    0.upto(@width - 1) do |index|
      header[letters[index]] = index
    end

    render_row(header.keys.to_a)
  end


  def render
    print "\n    "
    render_column_header

    1.upto(@height) do |row_number|
        print row_number.to_s.rjust(2, '0') + "> "
        print render_row(row_status(row_number))
    end
    print "\n"
    print "Remaining flags: #{@number_of_mines - count_flags(@squares)}."
    print "\n\n"
  end


  def place_mines
    @squares.sample(@number_of_mines).each { |square| square.plant_mine }
  end


  def count_flags(squares)  #refactor with Array#count??
    flag_count = 0

    squares.each do |square|
      flag_count += 1 if square.status == "@"
    end

    flag_count
  end


  def process(move)
    target = find_square(move[:row], move[:column])[0]
    target.send(move[:command])
    #provide feedback
      #if target.mine --> defeat
  end


  def find_square(row, column)
    @squares.select { |square| square.x == column && square.y == row }
  end


  def feedback(target, move)
    # hit a mine?
    @defeat = true if target.mine && move[:command] == "clear"
    # win?
    # comment & go to next turn
  end

end
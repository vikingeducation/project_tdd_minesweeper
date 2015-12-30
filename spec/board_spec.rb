require 'board'

describe Board do

  let(:board){Board.new}

  it 'should be an instance of board' do
    expect(subject).to be_a(Board)
  end

  describe '#initialize' do
    # Board should be 10 x 10 by default.
    it "should initialize a grid that is 10 x 10" do
      expect(board.instance_variable_get(:@display_grid)).to eq(Array.new(10){Array.new(10){"-"}})
    end

    # It should start with 9 flags.
    it "should start with 9 flags" do
      expect(board.instance_variable_get(:@flags)).to eq(9)
    end
  end

=begin
  describe '#place_mines_randomly' do
    it "should place_mines_randomly on the grid" do
      board.place_mines_randomly
      mines = 0
      board.instance_variable_get(:@grid).each do |row|
        row.each do |spot|
          if spot == 'm'
            mines += 1
          end
        end
      end
      expect(mines).to eq(9)
    end
  end
=end
end
require 'board'

describe Board do

  let(:board){Board.new}

  it 'should be an instance of board' do
    expect(subject).to be_a(Board)
  end

  describe '#initialize' do
    # Board should be 10 x 10 by default.
    it "should initialize a display grid that is 10 x 10 and contains '-' in all spots" do
      expect(board.instance_variable_get(:@display_grid)).to eq(Array.new(10){Array.new(10){"-"}})
    end

    # It should start with 9 flags.
    it "should start with 9 flags" do
      expect(board.instance_variable_get(:@flags)).to eq(9)
    end
  end

  describe '#place_random_mines' do
    # It should start set up 9 mines in random places randomly on the answer grid
    it "should set up 9 mines randomly on the answer grid" do
      board.place_random_mines
      mines = 0
      board.instance_variable_get(:@answer_grid).each do |y|
        y.each do |spot|
          if spot == 'm'
            mines += 1
          end
        end
      end
      expect(mines).to eq(9)
    end

    it 'calls the space_is_nil? method' do
      allow(board).to receive(:space_is_nil?).and_return(true)
      expect(board).to receive(:space_is_nil?)
      board.place_random_mines
    end
  end

  describe '#set_up_rest_of_answer_grid' do
    it 'calls the how_many_mines_touching method' do
      allow(board).to receive(:how_many_mines_touching).and_return(nil)
      expect(board).to receive(:how_many_mines_touching)
      board.set_up_rest_of_answer_grid
    end
=begin
    # I want to check that the board does not include nils
    it 'fills the answer grid with numbers from the how_many_mines_touching method' do
      allow(board).to receive(:how_many_mines_touching).and_return(1)
      board.set_up_rest_of_answer_grid
    end
=end
  end

  describe '#how_many_mines_touching' do
    before(:each) do
      board.instance_variable_set(:@answer_grid, [['m','m','m',nil,nil,nil,nil,nil,nil,nil],
                                                  ['m',nil,'m',nil,nil,nil,nil,nil,nil,nil],
                                                  ['m','m','m',nil,nil,nil,nil,nil,nil,nil],
                                                  [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                                  [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                                  [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                                  [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                                  [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                                  [nil,nil,nil,nil,nil,nil,nil,nil,'m',nil],
                                                  [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]])
    end

    it 'returns 1 if square is touching only one mine and that mine is top-left' do
      expect(board.how_many_mines_touching(9, 9)).to eq(1)
    end

    it 'returns 1 if square is touching only one mine and that mine is top' do
      expect(board.how_many_mines_touching(9, 8)).to eq(1)
    end

    it 'returns 1 if square is touching only one mine and that mine is top-right' do
      expect(board.how_many_mines_touching(9, 7)).to eq(1)
    end

    it 'returns 1 if square is touching only one mine and that mine is right' do
      expect(board.how_many_mines_touching(8, 7)).to eq(1)
    end

    it 'returns 1 if square is touching only one mine and that mine is bottom-right' do
      expect(board.how_many_mines_touching(7, 7)).to eq(1)
    end

    it 'returns 1 if square is touching only one mine and that mine is bottom' do
      expect(board.how_many_mines_touching(7, 8)).to eq(1)
    end

    it 'returns 1 if square is touching only one mine and that mine is bottom-left' do
      expect(board.how_many_mines_touching(7, 9)).to eq(1)
    end

    it 'returns 1 if square is touching only one mine and that mine is left' do
      expect(board.how_many_mines_touching(8, 9)).to eq(1)
    end

    it 'returns 8 if square is completely surrounded by mines' do
      expect(board.how_many_mines_touching(1, 1)).to eq(8)
    end

  end

end
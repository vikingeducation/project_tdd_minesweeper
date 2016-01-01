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

    it 'calls the how_many_mines_touching method' do
      allow(board).to receive(:how_many_mines_touching).and_return(nil)
      expect(board).to receive(:how_many_mines_touching)
      board.set_up_rest_of_answer_grid
    end

    it "sets an 8 in a spot that's touching 8 mines" do
      board.set_up_rest_of_answer_grid
      board_test = board.instance_variable_get(:@answer_grid)
      expect(board_test[1][1]).to eq(8)
    end

    it "sets a 2 in a spot that's touching 2 mines" do
      board.set_up_rest_of_answer_grid
      board_test = board.instance_variable_get(:@answer_grid)
      expect(board_test[0][3]).to eq(2)
    end

    it "sets a 3 in a spot that's touching 3 mines" do
      board.set_up_rest_of_answer_grid
      board_test = board.instance_variable_get(:@answer_grid)
      expect(board_test[3][3]).to eq(1)
    end

    it "sets an 1 in a spot that's touching 1 mine" do
      board.set_up_rest_of_answer_grid
      board_test = board.instance_variable_get(:@answer_grid)
      expect(board_test[1][3]).to eq(3)
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

  describe '#win?' do
    it 'returns true' do
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
      board.instance_variable_set(:@display_grid, [['m','m','m',nil,nil,nil,nil,nil,nil,nil],
                                                  ['m',nil,'m',nil,nil,nil,nil,nil,nil,nil],
                                                  ['m','m','m',nil,nil,nil,nil,nil,nil,nil],
                                                  [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                                  [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                                  [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                                  [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                                  [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                                  [nil,nil,nil,nil,nil,nil,nil,nil,'m',nil],
                                                  [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]])
      expect(board.win?).to eq(true)
    end

    it 'returns false if the display_grid and answer_grids are not the same' do
      expect(board.win?).to eq(false)
    end
  end

  describe '#lose?' do
    it 'returns false' do
      expect(board.lose?).to eq(false)
    end

    it 'returns true if the display_grid contains an !' do
      board.instance_variable_set(:@display_grid, [['m','m','m',nil,nil,nil,nil,nil,nil,nil],
                                                   ['m',nil,'m',nil,nil,nil,nil,nil,nil,nil],
                                                   ['m','m','m',nil,nil,nil,nil,nil,nil,nil],
                                                   [nil,nil,nil,nil,'!',nil,nil,nil,nil,nil],
                                                   [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                                   [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                                   [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                                   [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil],
                                                   [nil,nil,nil,nil,nil,nil,nil,nil,'m',nil],
                                                   [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]])
      expect(board.lose?).to eq(true)
    end
  end

  describe '#place_players_move' do
    it 'calls the add_or_remove_flag method if the argument has an f as its first letter' do
      allow(board).to receive(:add_or_remove_flag).and_return(true)
      expect(board).to receive(:add_or_remove_flag)
      board.place_players_move('f33')
    end

    it 'calls the open_on_display_grid method if the argument has an o as its first letter' do
      allow(board).to receive(:open_on_display_grid).and_return(true)
      expect(board).to receive(:open_on_display_grid)
      board.place_players_move('o33')
    end
  end

  describe '#add_or_remove_flag' do

    before do
        board.instance_variable_set(:@display_grid, [['f','-','-','-','-','-','-','-','-','-'],
                                                     ['-','-','-','-','-','-','-','-','-','-'],
                                                     ['-','-',3,'-','-','-','-','-','-','-'],
                                                     ['-','-','-','-','-','-','-','-','-','-'],
                                                     ['-','-','-','-','-','-','-','-','-','-'],
                                                     ['-','-','-','-','-','-','-','-','-','-'],
                                                     ['-','-','-','-','-','-','-','-','-','-'],
                                                     ['-','-','-','-','-','-','-','-','-','-'],
                                                     ['-','-','-','-','-','-','-','-','-','-'],
                                                     ['-','-','-','-','-','-','-','-','-','-']])
      end

    it 'does nothing if a player has chosen a spot with a number on it' do
      board.add_or_remove_flag(2, 2)
      display = board.instance_variable_get(:@display_grid)
      expect(display[2][2]).to eq(3)
    end

    context 'a player has chosen to flag a spot with a flag already on it' do
      it 'remove a flag from the position that was chosen' do
        board.add_or_remove_flag(0, 0)
        display = board.instance_variable_get(:@display_grid)
        expect(display[0][0]).to eq('-')
      end

      it 'increases the flag count' do
        board.add_or_remove_flag(0, 0)
        expect(board.instance_variable_get(:@flags)).to eq(10)
      end
    end

    context 'a player has chosen to flag a spot that is unopen' do
      it 'adds a flag to the position that was chosen' do
        board.add_or_remove_flag(1, 1)
        display = board.instance_variable_get(:@display_grid)
        expect(display[1][1]).to eq('f')
      end

      it 'decreases the flag count' do
        board.add_or_remove_flag(1, 1)
        expect(board.instance_variable_get(:@flags)).to eq(8)
      end
    end

  # What are we testing? Well what does the method do, it either adds a flag to the display grid
  # or if the position described by the argument on the display grid already has a flag on it
  # remove the flag.
  # Also increase or decrease the flag count depending on that situation.
  # I'm sensing four tests
  # 1. in a situation where the coordinates given already has a flag on it, we want to test that
  # that the flag is removed
  # 2. In a situation where the coordinates given doesn't have a flag on it, we want to add the flag
  # 
=begin
    check with display grid if the coordinates given has a flag on it, if it does,
      change that flag back to a '-' and increase the flag count by 1
    else
      change that coordinate from a '-' into a flag and decrease the count by 1
    end
=end
  end
end
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
      board.instance_variable_set(:@answer_grid, [['m','m','m',2,0,0,0,0,0,0],
                                                  ['m',8,'m',3,0,0,0,0,0,0],
                                                  ['m','m','m',2,0,0,0,0,0,0],
                                                  [2,3,2,1,0,0,0,0,0,0],
                                                  [0,0,0,0,0,0,0,0,0,0],
                                                  [0,0,0,0,0,0,0,0,0,0],
                                                  [0,0,0,0,0,0,0,0,0,0],
                                                  [0,0,0,0,0,0,0,1,1,1],
                                                  [0,0,0,0,0,0,0,1,'m',1],
                                                  [0,0,0,0,0,0,0,1,1,1]])
      board.instance_variable_set(:@display_grid, [['f','f','f',2,0,0,0,0,0,0],
                                                  ['f',8,'f',3,0,0,0,0,0,0],
                                                  ['f','f','f',2,0,0,0,0,0,0],
                                                  [2,3,2,1,0,0,0,0,0,0],
                                                  [0,0,0,0,0,0,0,0,0,0],
                                                  [0,0,0,0,0,0,0,0,0,0],
                                                  [0,0,0,0,0,0,0,0,0,0],
                                                  [0,0,0,0,0,0,0,1,1,1],
                                                  [0,0,0,0,0,0,0,1,'f',1],
                                                  [0,0,0,0,0,0,0,1,1,1]])
      expect(board.win?).to eq(true)
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
      allow(board).to receive(:open_square).and_return(true)
      expect(board).to receive(:open_square)
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
  end

  describe '#open_square' do
    before do
      board.instance_variable_set(:@answer_grid, [['m','m','m',2,0,0,0,0,0,0],
                                                  ['m',8,'m',3,0,0,0,0,0,0],
                                                  ['m','m','m',2,0,0,0,0,0,0],
                                                  [2, 3, 2, 1,0,0,0,0,0,0],
                                                  [0,0,0,0,0,0,0,0,0,0],
                                                  [0,0,0,0,0,0,0,0,0,0],
                                                  [0,0,0,0,0,0,0,0,0,0],
                                                  [0,0,0,0,0,0,0,1,1,1],
                                                  [0,0,0,0,0,0,0,1,'m',1],
                                                  [0,0,0,0,0,0,0,1,1,1]])
      board.instance_variable_set(:@display_grid, [['f','-','-','-','-','-','-','-','-','-'],
                                                   ['-','-','-',3,'-','-','-','-','-','-'],
                                                   ['-','-','-','-','-','-','-','-','-','-'],
                                                   ['-','-','-','-','-','-','-','-','-','-'],
                                                   ['-','-','-','-','-','-','-','-','-','-'],
                                                   ['-','-','-','-','-','-','-','-','-','-'],
                                                   ['-','-','-','-','-','-','-','-','-','-'],
                                                   ['-','-','-','-','-','-','-','-','-','-'],
                                                   ['-','-','-','-','-','-','-','-','-','-'],
                                                   ['f','-','-','-','-','-','-','-','-','-']])
    end

    # 1 opening up a square that is a number above 0
    it 'opens up a square that is a number ABOVE 0' do
      board.open_square(1,1)
      display = board.instance_variable_get(:@display_grid)
      expect(display[1][1]).to eq(8)
    end

    # 2 opening up a square that's already open
    it "doesn't change anything if square is already open" do
      board.open_square(1,3)
      display = board.instance_variable_get(:@display_grid)
      expect(display[1][3]).to eq(3)
    end

    # 3 opening up a square with a flag on it
    it "doesn't change anything if square has a flag on it" do
      board.open_square(0,0)
      display = board.instance_variable_get(:@display_grid)
      expect(display[0][0]).to eq('f')
    end

    context 'player has opened a square that has a mine on it' do    
      it "changes the square to an apostrophe" do
        board.open_square(0,1)
        display = board.instance_variable_get(:@display_grid)
        expect(display[0][1]).to eq('!')
      end
    end

    context 'player has opened a square that is not touching any mines' do
      # 4 opening up a square that is a number that is 0
      it "opens up the square if it's zero" do
        board.open_square(0,4)
        display = board.instance_variable_get(:@display_grid)
        expect(display[0][4]).to eq(0)
      end

      it 'it calls the open_surround_squares method' do
        allow(board).to receive(:open_surrounding_squares)
        expect(board).to receive(:open_surrounding_squares)
        board.open_square(0,4)
      end

      it 'opens up all adjacent squares' do
        board.open_square(0,4)
        display = board.instance_variable_get(:@display_grid)
        expect(display[7][7]).to eq(1)
      end

      it 'opens up all adjacent squares' do
        board.open_square(0,4)
        display = board.instance_variable_get(:@display_grid)
        expect(display[0][5]).to eq(0)
      end

      it 'does not open squares that are not directly touching a zero' do
        board.open_square(0,4)
        display = board.instance_variable_get(:@display_grid)
        expect(display[1][1]).to eq('-')
      end

      it 'does not open squares that are flagged' do
        board.open_square(0,4)
        display = board.instance_variable_get(:@display_grid)
        expect(display[9][0]).to eq('f')
      end
    end
  end
end
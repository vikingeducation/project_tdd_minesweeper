#everything cell
#3 boolean attributes
#mine = false?
#hidden = true ?
#flagged = false?

#1 integer attribute
#adjacent_mines = nil (going to be set the moment it exists, is set on the 2nd pass)
require 'minesweeper'
describe Cell do
  let(:my_cell) {Cell.new}
  
  it 'initializes as hidden'do    
    expect(my_cell.hidden).to eq(true)
  end
  
  describe '#adjacent_mines' do    
    it 'should initialize with a 0 value' do
      expect(my_cell.adjacent_mines).to eq(0)
    end

    it 'can explicitly have adjacent mines changed to a number' do
      my_cell.adjacent_mines = 6
      expect(my_cell.adjacent_mines).to eq(6)
    end

    it 'should have a value as an integer' do
      my_cell.adjacent_mines = 4
      expect(my_cell.adjacent_mines.is_a?(Integer)).to eq(true)    
    end
  end
  
  describe '#symbolize' do
    it 'should represent F if it is flagged' do
      my_cell.flagged = true
      expect(my_cell.symbolize).to eq("F")
    end
    it 'should represent mine as ■' do
      my_cell.mine = true
      my_cell.hidden = false
      expect(my_cell.symbolize).to eq("■")
    end
    it 'should represent hidden as □' do
      expect(my_cell.symbolize).to eq("□")
    end
    it 'should represent hidden as □ even if it is a mine' do
      my_cell.mine = true
      expect(my_cell.symbolize).to eq("□")
    end
    it 'should represent adjacent_mines as a number (stringed)' do
      my_cell.hidden = false
      my_cell.adjacent_mines = 5
      expect(my_cell.symbolize).to eq("5")
    end
  end
  
  it 'initializes without a mine' do
    expect(my_cell.mine).to eq(false)
  end
  
  it 'should be able to contain a mine' do
    my_cell.mine = true
    expect(my_cell.mine).to eq(true)
  end
  
  it 'can receive a flag' do
    my_cell.flagged = true
    expect(my_cell.flagged).to eq(true)
  end
  
  it 'initializes as hidden' do
    expect(my_cell.hidden).to eq(true)
  end
end

describe Board do
  let(:my_array){Board.new}
  let(:my_mines){[2, 47, 55, 11, 6, 90, 91, 92, 93, 94]}
  
  context 'initialize' do
    it 'initializes as an Array' do
      expect(my_array.board.is_a?(Array)).to eq(true)
    end

    it 'should be full of cells' do
      expect(my_array.board[4][3].kind_of?(Cell)).to eq(true)
    end
  end
  
  describe '#generate_mines' do
    it 'returns an array' do
      expect(my_array.generate_mines.is_a?(Array)).to eq(true)
    end
    it 'returns an array of Integers' do
      mines_array = my_array.generate_mines
      mines_array.each do |num|
        expect(num.is_a?(Integer)).to eq(true)
      end
    end
    it 'returns an array of unique Integers' do
      mines_array = my_array.generate_mines
      expect(mines_array.uniq.length).to eq(10)
    end
  end  
 
  describe '#check_victory?' do 
    it 'confirms a victory' do
      my_array.board.flatten.each do |x|
        x.mine = false
        x.hidden = false
      end
      expect(my_array.check_victory?).to eq(true)
    end
  end
  
  describe '#check_loss?' do
    it 'displays a loss' do
      my_array.board.flatten.each do |x|
        x.mine = true
        x.hidden = false
      end
      expect(my_array.check_loss?).to eq(true)
    end    
  end
end

describe Player do
  let (:player) {Player.new}
  
  it 'should be able to quit a game' do
    #WHERE WE LEFT OFFFF
  end  
end
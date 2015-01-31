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
    let(:my_cell) {Cell.new}
    
    it 'should initialize with a nil value' do
      expect(my_cell.adjacent_mines).to eq(nil)
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
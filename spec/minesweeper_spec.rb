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

  describe '#apply mines' do
    it 'has ten mines' do
      mine_number
      my_array.flatten.each do |x|
        if x.mine == true
          mine_number +=1
        end
      end
      expect(mine_number).to eq(10)
    end
#     #next steps write method to apply mines
#   end
    it 'creates a 10*10 array of blank Cells'
    it 'sets some of the Cells as mines'
#    expect(my_array[2][0].mine).to eq(true)
    it 'sets some of the Cells as numbers'
#  end
  
#   #step 1
#   i = 1
#   my_array.each do |x|
#     x = i
#     i += 1
#   end
#   def make_me_some_mines
#   my_array.each do |y|
    
#       if my_mines.include?(y)
#         y = Cell.new.mine(true)
#       else
#         y = Cell.new
#       end
#     end
#   end
  
  
  describe '#render' do
  end
end
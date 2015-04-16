require('minesweeper')

describe Minesweeper do
	let(:board){ double() }
  let(:player){ double() }

  before(:each) do
    allow(Player).to receive(:new).and_return(player)
    allow(Board).to receive(:new).and_return(board)
  end

	describe "#initialize" do
		it 'creates a new board object' do
			expect(Board).to receive(:new).with(10,9)
			Minesweeper.new
		end

		it 'creates a new player object' do
			expect(Player).to receive(:new)
			Minesweeper.new
		end
	end
end

describe Board do

  describe "#initialize" do
  	# FAIL
  	it 'calls create_board with size 10, 9' do
  		expect(Board).to receive(:create_board).with(10,9)
  		Board.new(10,9)
  	end

  	it 'sets @flags_remaining' do
  		b = Board.new(10,9)
  		expect(b.flags_remaining).to eq(9)
  	end
  end

  describe "#create_board" do
  	let(:square){double(:mine => false).as_null_object}

		before do
			allow(Square).to receive(:new).and_return(square)
		end

  	it 'creates new Square object 100 times' do
  		size = 10
  		expect(Square).to receive(:new).exactly(size*size).times
  		Board.new(size,9)
  	end

  	# FAIL
  	it 'calls the set_mines method' do
  		expect(Board.new(10,9)).to receive(:set_mines)
  	end
  end

end

describe Square do
	let(:s){Square.new([1,1])}

	describe "#make_mine" do
		it 'turns the square into a mine' do
			s.make_mine
			expect(s.mine).to eq(true)
		end
	end
end

describe Player do

end
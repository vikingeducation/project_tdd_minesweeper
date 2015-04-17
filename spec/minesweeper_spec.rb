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

		# QUESTION: Why doesn't this work when I remove the let and before statements above?
		it 'creates a new player object' do
			expect(Player).to receive(:new)
			Minesweeper.new
		end
	end
end

describe Board do
	let(:new_board){Board.new(10,9)}
	let(:s){new_board.get_square([1,1])}

  describe "#initialize" do
  	it 'sets @flags_remaining' do
  		expect(new_board.flags_remaining).to eq(9)
  	end
  end

  describe "#create_board" do
	  it "fills the board with square objects" do
	    new_board.create_board(10,9)
	    expect(new_board.board.flatten.all?{ |square| square.is_a?(Square)}).to eq(true)
	  end

	  it 'fills the board with 100 objects' do
	  	new_board.create_board(10,0)
	  	expect(new_board.board.flatten.length).to eq(100)
	  end
	end

	describe 'adjacent mines for the board' do
		it 'surrounding_mines is 0 if there are no mines surrounding the square' do
			# Create a small board w/ no mines
			b = Board.new(2,0)
			expect(b.get_square([1,1]).surrounding_mines).to eq(0)
		end

		it 'surrounding_mines is 1 w/ 1 mine surrounding the square' do
			b = Board.new(2,0)
			b.get_square([1,2]).make_mine  # Set 1 mine
			b.add_surrounding_mines				 # Need to reset the mine count
			expect(b.get_square([1,1]).surrounding_mines).to eq(1)
		end

		it 'surrounding_mines is 2 w/ 2 mine surrounding the square' do
			b = Board.new(2,0)
			b.get_square([1,2]).make_mine  # Set 1 mine
			b.get_square([2,2]).make_mine  # Set 2 mines
			b.add_surrounding_mines				 # Need to reset the mine count
			expect(b.get_square([1,1]).surrounding_mines).to eq(2)
		end

		it 'surrounding_mines is 3 w/ 3 mine surrounding the square' do
			b = Board.new(2,0)
			b.get_square([1,2]).make_mine  # Set 1 mine
			b.get_square([2,2]).make_mine  # Set 2 mines
			b.get_square([2,1]).make_mine  # Set 3 mines
			b.add_surrounding_mines				 # Need to reset the mine count
			expect(b.get_square([1,1]).surrounding_mines).to eq(3)
		end
	end

	# These render tests seem to mess with things, 
	# let's take a look at them later.
	# describe "#render" do
	# 	it 'renders a blank board at first' do
	# 		expect{new_board.render}.to output(/O/).to_stdout
	# 	end

	# 	it 'renders a F if a flag is set' do
	# 		new_board.get_square([1,1]).switch_flag
	# 		expect{new_board.render}.to output(/F/).to_stdout
	# 	end

	# 	it 'calls :clear' do
	# 		expect(new_board).to receive(:clear)
	# 		new_board.render
	# 	end
	# end

	describe "#get_square" do
		it 'finds a Square object' do
			expect(new_board.get_square([1,1]).is_a?(Square)).to eq(true)
		end

		it 'finds the Square by coordinates' do
			s = new_board.get_square([1,1])
			expect(s.coords).to eq([1,1])
		end
	end

	describe "#switch_flag" do

		it 'adds a flag to the specific square' do
			new_board.switch_flag([1,1])
			expect(s.flag).to eq(true)
		end

		it 'decreases flags remaining if adding flag' do
			new_board.switch_flag([1,1])
			expect(new_board.flags_remaining).to eq(8)
		end

		it 'increases flags remaining if removing flag' do
			new_board.switch_flag([1,1])
			new_board.switch_flag([1,1])
			expect(new_board.flags_remaining).to eq(9)
		end
	end

	describe "#display_square" do
		it 'displays a Square that hasen\'t been displayed yet' do
			new_board.display_square([1,1])
			expect(s.displayed).to eq(true)
		end
	end

	describe "#get_all_mines" do
		it 'gets array of all mines with 1 mine set' do
			b = Board.new(2,0)
			b.get_square([2,1]).make_mine
			expect(b.get_all_mines).to include([2,1])
		end

		it 'gets array of all mines with 2 mine set' do
			b = Board.new(2,0)
			b.get_square([2,2]).make_mine
			b.get_square([2,1]).make_mine
			expect(b.get_all_mines).to include([2,1],[2,2])
		end
	end

	describe "#get_all_flags" do
		it 'gets coordinates for all flags' do
			small_board = Board.new(2,0)
			small_board.get_square([2,1]).switch_flag
			small_board.get_square([2,2]).switch_flag
			expect(small_board.get_all_flags).to include([2,2],[2,1])
		end
	end

	describe "#is_loss?" do
		it 'returns true if the selection is a mine' do
			small_board = Board.new(2,0)
			small_board.get_square([1,1]).make_mine
			expect(small_board.is_loss?([1,1])).to eq(true)
		end

		it 'returns false if the selection isn\'t a mine' do
			small_board = Board.new(2,0)
			small_board.get_square([2,1]).make_mine
			expect(small_board.is_loss?([1,1])).to eq(false)
		end
	end

	describe "#is_victory?" do
		it 'returns true if all flags array == all mines array' do
			sb = Board.new(2,0)
			sb.get_square([2,1]).make_mine
			sb.get_square([2,2]).make_mine
			sb.get_square([2,1]).switch_flag
			sb.get_square([2,2]).switch_flag
			expect(sb.is_victory?).to eq(true)
		end

		it 'returns false if all flags array != all mines array' do
			sb = Board.new(2,2)
			sb.get_square([2,1]).switch_flag
			expect(sb.is_victory?).to eq(false)
		end

		# Thought about it but don't have to check if both mines and flags
		# arrays are empty. Mines would never be empty since they get set in
		# the initialize function.
	end
end

describe Square do
	let(:s){Square.new([1,1],10)}

	describe "#make_mine" do
		it 'turns the square into a mine' do
			s.make_mine
			expect(s.mine).to eq(true)
		end
	end

	describe "#get_adjacent_squares" do
		it 'returns the coordinates of the surrounding squares on corner square' do
			test_square = Square.new([1,1],10)
			expect(test_square.adjacent_squares).to eq([[1,2],[2,1],[2,2]])
		end

		it 'returns the coordinates of the surrounding squares on left/right square' do
			test_square = Square.new([1,2],10)
			expect(test_square.adjacent_squares).to eq([[1,1],[1,3],[2,1],[2,2],[2,3]])
		end

		it 'returns the coordinates of the surrounding squares on up/down square' do
			test_square = Square.new([2,1],10)
			expect(test_square.adjacent_squares).to eq([[1,1],[1,2],[2,2],[3,1],[3,2]])
		end

		it 'returns the coordinates of the surrounding squares on non-edge square' do
			test_square = Square.new([2,2],10)
			expect(test_square.adjacent_squares).to eq([[1,1],[1,2],[1,3],[2,1],[2,3],[3,1],[3,2],[3,3]])
		end
	end

	describe "#switch_flag" do
		it 'sets @flag to true if false' do
			s.switch_flag
			expect(s.flag).to eq(true)	
		end

		it 'sets @flag to false if true' do
			s.flag=(true)
			s.switch_flag
			expect(s.flag).to eq(false)
		end
	end

	describe "#display_square" do
		it 'sets @displayed to true' do
			s.display_square
			expect(s.displayed).to eq(true)
		end
	end
end

describe Player do
	let(:p){Player.new(10)}

	describe "#get_move_type" do
		it 'returns 1 if input 1' do
			allow(p).to receive(:gets).and_return("1")
			allow(p).to receive(:puts).and_return(nil)
			expect(p.get_move_type).to eq(1)
		end

		it 'returns 2 if input 2' do
			allow(p).to receive(:gets).and_return("2")
			allow(p).to receive(:puts).and_return(nil)
			expect(p.get_move_type).to eq(2)
		end

		it 'returns false if input something else' do
			allow(p).to receive(:gets).and_return("hello")
			allow(p).to receive(:puts).and_return(nil)
			expect(p.get_move_type).to eq(false)
		end
	end

	describe "#valid_move_type?" do
		it 'returns true if given 1' do
			expect(p.valid_move_type?(1)).to eq(true)
		end

		it 'returns true if given 2' do
			expect(p.valid_move_type?(2)).to eq(true)
		end

		it 'returns false if given string' do
			expect(p.valid_move_type?("hello")).to eq(false)
		end

		it 'returns false if given float' do
			expect(p.valid_move_type?(1.5)).to eq(false)
		end
	end

	describe "#get_coordinates" do

		it 'returns the coordinates if valid' do
			allow(p).to receive(:gets).and_return("1,1")
			allow(p).to receive(:puts).and_return(nil)
			expect(p.get_coordinates(nil)).to eq([1,1])
		end

		it 'returns false if invalid' do
			allow(p).to receive(:gets).and_return("1,12")
			allow(p).to receive(:puts).and_return(nil)
			expect(p.get_coordinates(nil)).to eq(false)
		end
	end

	describe "#valid_coordinates" do
		it 'returns true given valid coordinates' do
			expect(p.valid_coordinates([1,1])).to eq(true)
		end

		it 'returns false given 1 number' do
			expect(p.valid_coordinates([1])).to eq(false)
		end

		it 'returns false given 3 numbers' do
			expect(p.valid_coordinates([1,1,1])).to eq(false)
		end

		it 'returns false given string' do
			# Remember, any string.to_i == 0
			expect(p.valid_coordinates([1,0])).to eq(false)
		end

		it 'returns false given coordinates outside of range' do
			expect(p.valid_coordinates([12,1])).to eq(false)
		end
	end
end
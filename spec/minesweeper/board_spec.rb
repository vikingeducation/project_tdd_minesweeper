require 'spec_helper'

describe Board do
	let(:board){Board.new}
	let(:board_easy_state) do 
		board.state = [
			'02MMMMMMMM',
			'23MMMMMMMM',
			'MMMMMMMMMM',
			'MMMMMMMMMM',
			'MMMMMMMMMM',
			'MMMMMMMMMM',
			'MMMMMMMMMM',
			'MMMMMMMMMM',
			'MMMMMMMMMM',
			'MMMMMMMMMM'
		]
		board
	end

	describe '#initialize' do
		it 'accepts an options hash as input' do
			expect do
				Board.new({})
			end.to_not raise_error
		end

		it 'sets mines automatically to 9' do
			expect(board.mines).to eq(9)
		end

		it 'sets the state when no state is given' do
			expect(board.state).to_not be_nil
		end

		it 'allows the state to be passed as a options parameter' do
			expect do
				Board.new(:state => BLANK_STATE)
			end.to_not raise_error
		end
	end

	describe '#non_mine_coordinates' do
		it 'returns an array of all the coordinates that are not mine squares' do
			board.state = [
				'3MMMMMMMMM',
				'MMMMMMMMMM',
				'MMMMMMMMMM',
				'MMMMMMMMMM',
				'MMMMMMMMMM',
				'MMMMMMMMMM',
				'MMMMMMMMMM',
				'MMMMMMMMMM',
				'MMMMMMMMMM',
				'MMMMMMMMM3'
			]
			expect(board.non_mine_coordinates).to eq([[0, 0], [9, 9]])
		end
	end

	describe '#mine_coordinates' do
		it 'returns an array of all the coordinates that are mine squares' do
			board.state = [
				'M100000000',
				'1100000000',
				'0000000000',
				'0000000000',
				'0000000000',
				'0000000000',
				'0000000000',
				'0000000000',
				'0000000011',
				'000000001M'
			]
			expect(board.mine_coordinates).to eq([[0, 0], [9, 9]])
		end
	end

	describe '#each_clearable' do
		it 'accepts a block and x,y value' do
			expect do
				board.each_clearable(0, 0) do
				end
			end.to_not raise_error
		end

		it 'passes the x and y value of each clearable square to the given block' do
			clearables = []
			board_easy_state.each_clearable(0, 0) do |x, y|
				clearables << [y, x]
			end
			expect(clearables).to eq([[0, 0], [1, 1], [0, 1], [1, 0]])
		end
	end

	describe '#clearables' do
		it 'returns an array of all the clearable squares for the given coordinates' do
			clearables = board_easy_state.clearables(0, 0)
			expect(clearables).to eq([[0, 0], [1, 1], [0, 1], [1, 0]])
		end
	end

	describe '#mine?' do
		it 'returns true if the square at x,y is a mine' do
			expect(board_easy_state.mine?(9, 9)).to eq(true)
		end

		it 'returns false if the square at x,y is not a mine' do
			expect(board_easy_state.mine?(0, 0)).to eq(false)
		end
	end

	describe '#not_mine?' do
		it 'returns true if the square at x,y is a mine' do
			expect(board_easy_state.not_mine?(9, 9)).to eq(false)
		end

		it 'returns false if the square at x,y is not a mine' do
			expect(board_easy_state.not_mine?(0, 0)).to eq(true)
		end
	end

	describe '#near_mine?' do
		it 'returns true if the square at x,y is near a mine' do
			expect(board_easy_state.near_mine?(1, 1)).to eq(true)
		end

		it 'returns false if the square at x,y is not near a mine' do
			expect(board_easy_state.near_mine?(0, 0)).to eq(false)
		end
	end

	describe '#not_near_mine?' do
		it 'returns true if the square at x,y is near a mine' do
			expect(board_easy_state.not_near_mine?(1, 1)).to eq(false)
		end

		it 'returns false if the square at x,y is not near a mine' do
			expect(board_easy_state.not_near_mine?(0, 0)).to eq(true)
		end
	end
end

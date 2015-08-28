require 'spec_helper'

describe Board do
	let(:board){Board.new}

	describe '#initialize' do
		it 'accepts an options hash as input'
		it 'sets mines automatically to 9'
		it 'sets the state when no state is given'
		it 'allows the state to be passed as a options parameter'
	end

	describe '#select_coordinates' do
		it 'accepts a block'
		it 'yields the x and y value of all the squares in the state'
		it 'returns the coordinates in state that match the return value of the given block'
	end

	describe '#non_mine_coordinates' do
		it 'returns an array of all the coordinates that are not mine squares'
	end

	describe '#mine_coordinates' do
		it 'returns an array of all the coordinates that are mine squares'
	end

	describe '#each_clearable' do
		it 'accepts a block'
		it 'accepts an x and y value'
		it 'passes the x and y value of each clearable square to the given block'
	end

	describe '#clearables' do
		it 'returns an array of all the clearable squares for the given coordinates'
	end

	describe '#mine?' do
		it 'returns true if the square at x,y is a mine'
	end

	describe '#not_mine?' do
		it 'returns true if the square at x,y is not a mine'
	end

	describe '#near_mine?' do
		it 'returns true if the square at x,y is near a mine'
	end

	describe '#not_near_mine?' do
		it 'returns true if the square at x,y is not near a mine'
	end
end

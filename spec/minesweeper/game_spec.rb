require 'spec_helper'

describe Game do
	let(:game){Game.new}

	describe '#initialize' do
		it 'returns an instance of the Game class'
		it 'allows an options hash as a parameter'
		it 'allows player state to be set via options'
		it 'allows board state to be set via options'
		it 'allows debug to be set via options'
	end

	describe '#player' do
		it 'is an accessor'
	end

	describe '#board' do
		it 'is an accessor'
	end

	describe '#debug' do
		it 'is an accessor'
	end

	describe '#to_s' do
		it 'returns a string'
	end

	describe '#move' do
		it 'accepts a string as the first parameter'
		it 'accepts an integer as the 2nd 2 parameters'

		context 'the type is f' do
			it 'calls player#flag'
		end

		context 'the type is c' do
			it 'calls #clear'
			it 'replaces any index in player state marked C with the index from board'
			it 'substitues - for any 0 when replacing'
		end
	end

	describe '#cheat!' do
		it 'sets the player state to a winning state'
		it 'sets every non mine index on player to the value of the index on the board'
		it 'sets every mine index on player to F'
	end

	describe '#boom!' do
		it 'sets the player state to a losing state'
		it 'sets every mine index on player to M'
	end

	describe '#lose?' do
		it 'returns true when the player state is a losing state'
	end

	describe '#win?' do
		it 'returns true when the player state is a winning state'
	end
end

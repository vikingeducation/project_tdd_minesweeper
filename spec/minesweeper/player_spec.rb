require 'spec_helper'

describe Player do
	let(:player){Player.new}

	describe '#initialize' do
		it 'allows an options hash as input'
		it 'allows the state to be set via options'
	end

	describe '#flags' do
		it 'is an accessor'
	end

	describe '#flag' do
		it 'accepts and x and x value as parameters'

		context 'the square is flagged' do
			it 'sets the square at the given coordinates to 0'
			it 'increments flags'
		end

		context 'the square is not flagged' do
			it 'sets the square at the given coordinates to F'
			it 'decrements flags'
		end
	end

	describe '#clear' do
		it 'accepts and x and x value as parameters'
		it 'sets the state of the square to C'

		context 'the square is flagged' do
			it 'increments flags'
		end
	end

	describe '#each_cleared' do
		it 'accepts a block'
		it 'passes the x,y to the block of each square marked C'
	end

	describe '#flagged?' do
		it 'returns true if the square at x,y is F'
		it 'returns false it the square at x,y is not F'
	end

	describe '#not_flagged?' do
		it 'returns true if the square at x,y is not F'
		it 'returns false it the square at x,y is F'
	end

	describe '#cleared?' do
		it 'returns true if the square has been cleared'
		it 'returns false if the square has not been cleared'
	end

	describe '#not_cleared?' do
		it 'returns true if the square has not been cleared'
		it 'returns false if the square has been cleared'
	end
end

require 'spec_helper'

describe Minefield do
	let(:minefield){Minefield.new}

	describe '#initialize' do
		it 'accepts an options hash as a parameter'
		it 'allows state to be set via the options hash'
		it 'sets a blank state when no state is provided'
		it 'sets the size to 10 by default'
	end

	describe '#state=' do
		it 'sets the value of state to an array'
		it 'calls format_state and passes it the given parameter'
	end

	describe '#adjacents' do
		it 'always returns an array with length 8'
		it 'returns an array of only arrays each with length 2'
		it 'returns an array where each sub array only contains integers'
		it 'returns an array where the original coordinates are not present'
		it 'returns an array where the combinations of each coordinate -+ 1 are exhausted'
	end

	describe '#to_s' do
		it 'returns a string'
	end

	describe '#format_state' do
		context 'the parameter is an array' do
			it 'calls decompress when the array is compressed'
			it 'returns the original array if the array is not compressed'
		end

		context 'the parameter is a string' do
			it 'calls denormalize if the string is formatted correctly'
		end
	end

	describe '#blank_state' do
		it 'returns a 2d array with each sub array index containing a 0'
		it 'returns an array where the array and all the sub arrays have lengths of Game#board#size'
	end

	describe '#normalize' do
		it 'returns a string of the join from all sub arrays in the state'
	end

	describe '#denormalize' do
		it 'returns a state array representation of the given string'
		it 'it casts the numeric strings to integers'
	end

	describe '#compress' do
		it 'joins the sub arrays of the state'
	end

	describe '#decompress' do
		it 'splits the sub arrays of the given state'
		it 'it casts the numeric strings to integers'
	end

	describe '#in_bounds?' do
		it 'returns true when a coordinate pair is inside the range of the size'
		it 'returns false when a coordinate pair is outside the range of the size'
	end
end

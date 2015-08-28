require 'spec_helper'

describe Minefield do
	let(:minefield){Minefield.new}
	let(:minefield_state){Minefield.new(:state => BLANK_STATE)}

	describe '#initialize' do
		it 'accepts an options hash as a parameter' do
			expect {minefield_state}.to_not raise_error
		end

		it 'allows state to be set via the options hash' do
			expect {minefield_state}.to_not raise_error
		end

		it 'sets a blank state when no state is provided' do
			expect(minefield.state).to_not be_nil
		end

		it 'sets the size to 10 by default' do
			expect(minefield.size).to eq(10)
		end
	end

	describe '#select_coordinates' do
		it 'accepts a block' do
			expect do
				minefield.select_coordinates do
				end
			end.to_not raise_error
		end

		it 'yields the x and y value of all the squares in the state' do
			coordinates = minefield.select_coordinates {true}
			all_coordinates = Array.new(minefield.size**2) do |i|
				[i / minefield.size, i % minefield.size]
			end
			expect(coordinates).to eq(all_coordinates)
		end

		it 'returns an array of only the coordinates where the block yielded true' do
			coordinates = minefield.select_coordinates {false}
			expect(coordinates).to be_empty
		end
	end

	describe '#state=' do
		it 'sets the value of state to an array' do
			minefield.state = BLANK_STATE
			expect(minefield.state).to be_kind_of(Array)
		end

		it 'calls format_state and passes it the given parameter' do
			expect(minefield).to receive(:format_state).with('The given parameter')
			minefield.state = 'The given parameter'
		end
	end

	describe '#adjacents' do
		let(:adjacents){minefield.adjacents(0, 0)}

		it 'always returns an array with length 8' do
			100.times do
				x = rand(0..10)
				y = rand(0..10)
				expect(minefield.adjacents(x, y).length).to eq(8)
			end
		end

		it 'returns an array of only arrays each with length 2' do
			100.times do
				x = rand(0..10)
				y = rand(0..10)
				adjacents = minefield.adjacents(x, y)
				expect(adjacents.all? {|a| a.length == 2}).to eq(true)
			end
		end

		it 'returns an array where each sub array only contains integers' do
			results = []
			adjacents.each do |a|
				results << a[0]
				results << a[1]
			end
			expect(results.all? {|i| i.is_a?(Integer)}).to eq(true)
		end

		it 'returns an array where the original coordinates are not present' do
			expect(adjacents.include?([0, 0])).to eq(false)
		end

		it 'returns an array where the combinations of each coordinate -+ 1 are exhausted' do
			[
				[0, -1],
				[0, 1],
				[-1, 0],
				[1, 0],
				[-1, -1],
				[-1, 1],
				[1, -1],
				[1, 1]
			].each do |c|
				expect(adjacents.include?(c)).to eq(true)
			end
		end
	end

	# 
	# 

	describe '#to_s' do
		it 'returns a string' do
			expect(minefield.to_s).to be_kind_of(String)
		end
	end

	describe '#format_state' do
		context 'the parameter is an array' do
			it 'calls decompress when the array is compressed' do
				expect(minefield).to receive(:decompress).with(PLAYER_WIN_COMPRESSED)
				minefield.format_state(PLAYER_WIN_COMPRESSED)
			end

			it 'returns the original array if the array is not compressed' do
				expect(minefield.format_state([])).to eq([])
			end
		end

		context 'the parameter is a string' do
			it 'calls denormalize if the string is formatted correctly' do
				expect(minefield).to receive(:denormalize).with(PLAYER_WIN_NORMALIZED)
				minefield.format_state(PLAYER_WIN_NORMALIZED)
			end
		end
	end

	describe '#blank_state' do
		let(:blank_state){minefield.blank_state}

		it 'returns a 2d array with each sub array index containing a 0' do
			blank_state.each do |r|
				expect(r.all? {|i| i == 0}).to eq(true)
			end
		end

		it 'returns an array where the array and all the sub arrays have lengths of #size' do
			expect(blank_state.all? {|r| r.length == minefield.size}).to eq(true)
			expect(blank_state.length).to eq(minefield.size)
		end
	end

	describe '#normalize' do
		it 'returns a string of the join from all sub arrays in the state' do
			minefield.state = PLAYER_WIN_NORMALIZED
			expect(minefield.normalize).to eq(PLAYER_WIN_NORMALIZED)
		end
	end

	describe '#denormalize' do
		it 'returns a state array representation of the given string' do
			expect(minefield.denormalize(BLANK_STATE_NORMALIZED)).to eq(BLANK_STATE)
		end

		it 'it casts the numeric strings to integers' do
			minefield.denormalize(BLANK_STATE_NORMALIZED).each do |r|
				expect(r.all? {|i| i.is_a?(Integer)}).to eq(true)
			end
		end
	end

	describe '#compress' do
		it 'joins the sub arrays of the state' do
			compressed = minefield.compress
			compressed.each do |r|
				expect(r).to eq('0' * minefield.size)
			end
		end
	end

	describe '#decompress' do
		it 'splits the sub arrays of the given state' do
			expect(minefield.decompress(BLANK_STATE_COMPRESSED)).to eq(BLANK_STATE)
		end
	end

	describe '#in_bounds?' do
		it 'returns true when a coordinate pair is inside the range of the size' do
			expect(minefield.in_bounds?(1, 1)).to eq(true)
		end

		it 'returns false when a coordinate pair is outside the range of the size' do
			expect(minefield.in_bounds?(minefield.size, 0)).to eq(false)
			expect(minefield.in_bounds?(-1, 0)).to eq(false)
		end
	end
end


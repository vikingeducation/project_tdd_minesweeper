require 'spec_helper'

describe Player do
	let(:player){Player.new}

	describe '#initialize' do
		it 'returns an instance of the Player class' do
			expect(player).to be_an_instance_of(Player)
		end

		it 'allows an options hash as input' do
			expect do
				Player.new({})
			end.to_not raise_error
		end

		it 'allows the state to be set via options' do
			expect do
				Player.new(:state => BLANK_STATE)
			end.to_not raise_error
		end
	end

	describe '#flags' do
		it 'is an accessor' do
			expect do
				player.flags
				player.flags = nil
			end.to_not raise_error
		end
	end

	describe '#flag' do
		it 'accepts and x and x value as parameters' do
			expect do 
				player.flag(0, 0)
			end.to_not raise_error
		end

		context 'the square is flagged' do
			before do
				player.state[0][0] = 'F'
				player.flags = 8
				player.flag(0, 0)
			end

			it 'sets the square at the given coordinates to 0' do
				expect(player.state[0][0]).to eq(0)
			end

			it 'increments flags' do
				expect(player.flags).to eq(9)
			end
		end

		context 'the square is not flagged' do
			before do
				player.flag(0, 0)
			end

			it 'sets the square at the given coordinates to F' do
				expect(player.state[0][0]).to eq('F')
			end

			it 'decrements flags' do
				expect(player.flags).to eq(8)
			end
		end
	end

	describe '#clear' do
		it 'accepts and x and x value as parameters' do
			expect do
				player.clear(0, 0)
			end.to_not raise_error
		end

		it 'sets the state of the square to C' do
			player.clear(0, 0)
			expect(player.state[0][0]).to eq('C')
		end

		context 'the square is flagged' do
			it 'increments flags' do
				before_flag = player.flags
				player.flag(0, 0)
				player.clear(0, 0)
				expect(player.flags).to eq(before_flag)
			end
		end
	end

	describe '#each_cleared' do
		it 'accepts a block' do
			expect do
				player.each_cleared do
				end
			end.to_not raise_error
		end

		it 'passes the x,y to the block of each square marked C' do
			player.clear(0, 0)
			player.clear(1, 1)
			cleared = []
			player.each_cleared do |x, y|
				cleared << [x, y]
			end
			expect(cleared).to eq([[0, 0], [1, 1]])
		end
	end

	# 
	# 

	describe '#flagged?' do
		before do
			player.state[0][0] = 'F'
		end

		it 'returns true if the square at x,y is F' do
			expect(player.flagged?(0, 0)).to eq(true)
		end

		it 'returns false it the square at x,y is not F' do
			expect(player.flagged?(1, 1)).to eq(false)
		end
	end

	describe '#not_flagged?' do
		before do
			player.state[0][0] = 'F'
		end

		it 'returns true if the square at x,y is not F' do
			expect(player.not_flagged?(1, 1)).to eq(true)
		end

		it 'returns false it the square at x,y is F' do
			expect(player.not_flagged?(0, 0)).to eq(false)
		end
	end

	describe '#cleared?' do
		before do
			player.state[0][0] = '-'
		end

		it 'returns true if the square has been cleared' do
			expect(player.cleared?(0, 0)).to eq(true)
		end

		it 'returns false if the square has not been cleared' do
			expect(player.cleared?(1, 1)).to eq(false)
		end
	end

	describe '#not_cleared?' do
		before do
			player.state[0][0] = '-'
		end

		it 'returns true if the square has not been cleared' do
			expect(player.not_cleared?(1, 1)).to eq(true)
		end

		it 'returns false if the square has been cleared' do
			expect(player.not_cleared?(0, 0)).to eq(false)
		end
	end
end

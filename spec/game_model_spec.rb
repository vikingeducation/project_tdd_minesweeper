require 'spec_helper'

describe GameModel do
	let(:game_model){GameModel.new}

	before do
		game_model.game.board.state = $board_normalized
	end

	describe '#initialize' do
		it 'returns an instance of the GameModel class'
		it 'creates a new game instance on the model'
	end

	describe '#clear' do
		it 'creates a new game instance'
		it 'sets model.game to the new instance'
	end

	describe '#move' do
		it 'accepts a string as a parameter'
		it 'raises an error if the parameter is not a string'
		
		context 'the input is a valid move' do
			it 'calls Game#move splitting the argument into the correct parameters'
			it 'returns true'
		end

		context 'the input is an invalid move' do
			it 'results in an error message being set on validation'
			it 'returns false'
		end
	end

	describe '#flags' do
		context 'the player has flags' do
			it 'returns the number of flags the player has'
		end

		context 'the player has no flags' do
			it 'returns a string'
		end
	end

	describe '#to_s' do
		it 'returns a string'
	end

	describe '#cheat' do
		it 'calls cheat! on the game'
	end

	describe '#boom' do
		it 'calls boom! on the game'
	end

	describe '#win?' do
		it 'calls win? on the game'
	end

	describe '#lose?' do
		it 'calls lose? on the game'
	end
end

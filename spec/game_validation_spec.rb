require 'spec_helper'

describe GameValidation do
	let(:game_model){GameModel.new}
	let(:game_validation){game_model.validation}
	let(:game){game_model.game}
	let(:player){game.player}
	let(:board){game.board}

	before do
		game.board.state = $board_normalized
	end

	describe '#initialize' do
		it 'returns an instance of the GameValidtion class'
	end

	describe '#valid_clear?' do
		it 'returns true if the player square is not yet cleared'

		context 'the square has already been cleared' do
			it 'returns false'
			it 'sets the appropriate error message'
		end
	end

	describe '#player_has_flags?' do
		it 'returns true if the player has flags'

		context 'the player does not have flags' do
			it 'returns false'
			it 'sets the appropriate error message'
		end
	end

	describe '#valid_move?' do
		it 'accepts a string as an argument'
		it 'raises an error if the argument is not a string'
		it 'calls valid_format?'

		context 'the format was valid' do
			it 'calls valid_coordinates?'

			context 'the coordinates were valid' do
				it 'calls valid_clear?'

				context 'the move is a flag' do
					it 'calls player_has_flags?'
				end
			end

			context 'the coordinates were invalid' do
				it 'does not call valid_clear?'
			end
		end

		context 'the format was invalid' do
			it 'does not call valid_coordinates?'
		end
	end

	describe '#valid_format?' do
		it 'returns true when the format follows the patten "[type] [x],[y]"'

		context 'the format is invalid' do
			it 'returns false'
			it 'sets the appropriate error message'
		end
	end

	describe '#valid_coordinates?' do
		it 'returns true when both x and y values are within the board size'

		context 'either x or y are outside the board size' do
			it 'returns false'
			it 'sets the appropriate error message'
		end
	end
end

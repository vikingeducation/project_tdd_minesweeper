require 'spec_helper'

describe GameValidation do
	let(:game_model){GameModel.new}
	let(:game_validation){game_model.validation}

	before do
		game_model.game.board.state = BOARD_NORMALIZED
	end

	describe '#initialize' do
		it 'returns an instance of the GameValidtion class' do
			expect(game_validation).to be_an_instance_of(GameValidation)
		end
	end

	describe '#valid_clear?' do
		it 'returns true if the player square is not yet cleared' do
			expect(game_validation.valid_clear?(1, 1)).to eq(true)
		end

		context 'the square has already been cleared' do
			it 'returns false' do
				game_model.move('c 1,1')
				expect(game_validation.valid_clear?(1, 1)).to eq(false)
			end

			it 'sets the appropriate error message' do
				game_model.move('c 1,1')
				game_validation.valid_clear?(1, 1)
				expect(game_validation.error).to match(/Error, square is already cleared at:/)
			end
		end
	end

	describe '#player_has_flags?' do
		it 'returns true if the player has flags' do
			expect(game_validation.player_has_flags?).to eq(true)
		end

		context 'the player does not have flags' do
			before do
				game_model.game.player.flags = 0
			end

			it 'returns false' do
				expect(game_validation.player_has_flags?).to eq(false)
			end

			it 'sets the appropriate error message' do
				game_validation.player_has_flags?
				expect(game_validation.error).to match(/Error, you do not have any flags left/)
			end
		end
	end

	describe '#valid_move?' do
		it 'accepts a string as an argument' do
			expect do
				game_validation.valid_move?('')
			end.to_not raise_error
		end

		it 'raises an error if the argument is not a string' do
			expect do
				game_validation.valid_move?(nil)
			end.to raise_error("Not a string")
		end

		it 'calls valid_format?' do
			expect(game_validation).to receive(:valid_format?)
			game_validation.valid_move?('')
		end

		context 'the format was valid' do

			it 'calls valid_coordinates?' do
				expect(game_validation).to receive(:valid_coordinates?).with('1', '1')
				game_validation.valid_move?('c 1,1')
			end

			context 'the coordinates were valid' do
				it 'calls valid_clear?' do
					expect(game_validation).to receive(:valid_clear?).with('1', '1')
					game_validation.valid_move?('c 1,1')
				end

				context 'the move is a flag' do
					it 'calls player_has_flags?' do
						expect(game_validation).to receive(:player_has_flags?)
						game_validation.valid_move?('f 1,1')
					end
				end
			end

			context 'the coordinates were invalid' do
				it 'does not call valid_clear?' do
					expect(game_validation).to_not receive(:valid_clear?)
					game_validation.valid_move?('c 1234,1234')
				end
			end
		end

		context 'the format was invalid' do
			it 'does not call valid_coordinates?' do
				expect(game_validation).to_not receive(:valid_coordinates?)
				game_validation.valid_move?('The quick brown fox...')
			end

			it 'sets the appropriate error message' do
				game_validation.valid_move?('Loud noises!')
				expect(game_validation.error).to match(/Error, expected move in form/)
			end
		end
	end

	# 
	# 

	describe '#valid_format?' do
		it 'returns true when the format follows the patten "[type] [x],[y]"' do
			expect(game_validation.valid_format?('f 1,1')).to eq(true)
		end

		context 'the format is invalid' do
			it 'returns false' do
				expect(game_validation.valid_format?('Fiddle sticks')).to eq(false)
			end

			it 'sets the appropriate error message' do
				game_validation.valid_format?('Ummm... pizza?')
				expect(game_validation.error).to match(/Error, expected move in form/)
			end
		end
	end

	describe '#valid_coordinates?' do
		it 'returns true when both x and y values are within the board size' do
			expect(game_validation.valid_coordinates?(1, 1)).to eq(true)
		end

		context 'either x or y are outside the board size' do
			it 'returns false' do
				expect(game_validation.valid_coordinates?(-1, -1)).to eq(false)
			end

			it 'sets the appropriate error message' do
				game_validation.valid_coordinates?(-1, -1)
				expect(game_validation.error).to match(/Error, x and y must both be between/)
			end
		end
	end
end


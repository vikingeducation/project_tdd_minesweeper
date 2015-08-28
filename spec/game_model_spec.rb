require 'spec_helper'

describe GameModel do
	let(:game_model){GameModel.new}

	before do
		game_model.game.board.state = BOARD_NORMALIZED
	end

	describe '#initialize' do
		it 'returns an instance of the GameModel class' do
			expect(game_model).to be_an_instance_of(GameModel)
		end

		it 'creates a new game instance on the model' do
			expect(game_model.game).to be_an_instance_of(Game)
		end
	end

	describe '#clear' do
		it 'creates a new game instance' do
			old_id = game_model.game.object_id
			game_model.clear
			expect(old_id).to_not eq(game_model.game.object_id)
		end
	end

	describe '#move' do
		it 'accepts a string as a parameter' do
			expect {game_model.move('')}.to_not raise_error
		end

		it 'raises an error if the parameter is not a string' do
			expect {game_model.move(nil)}.to raise_error("Not a string")
		end
		
		context 'the input is a valid move' do
			it 'calls Game#move splitting the argument into the correct parameters' do
				expect(game_model.game).to receive(:move).with('f', 0, 0)
				game_model.move('f 1,1')
			end

			it 'returns true' do
				expect(game_model.move('c 1,1')).to eq(true)
			end
		end

		context 'the input is an invalid move' do
			it 'results in an error message being set on validation' do
				game_model.move('c 1234,1234')
				expect(game_model.validation.error).to match(/Error/)
			end

			it 'returns false' do
				expect(game_model.move('c 1234,1234')).to eq(false)
			end
		end
	end

	# 
	# 

	describe '#flags' do
		context 'the player has flags' do
			it 'returns the number of flags the player has' do
				expect(game_model.flags).to eq(9)
			end
		end
	end

	describe '#to_s' do
		it 'returns a string' do
			expect(game_model.to_s).to be_kind_of(String)
		end
	end

	describe '#cheat' do
		it 'calls cheat! on the game' do
			expect(game_model.game).to receive(:cheat!)
			game_model.cheat
		end
	end

	describe '#boom' do
		it 'calls boom! on the game' do
			expect(game_model.game).to receive(:boom!)
			game_model.boom
		end
	end

	describe '#win?' do
		it 'calls win? on the game' do
			expect(game_model.game).to receive(:win?)
			game_model.win?
		end
	end

	describe '#lose?' do
		it 'calls lose? on the game' do
			expect(game_model.game).to receive(:lose?)
			game_model.lose?
		end
	end
end

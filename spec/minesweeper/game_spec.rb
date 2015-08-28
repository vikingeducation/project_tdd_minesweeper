require 'spec_helper'

describe Game do
	let(:game){Game.new}
	let(:game_state) do
		Game.new(
			:player => PLAYER_WIN_NORMALIZED,
			:board => BOARD_NORMALIZED
		)
	end

	describe '#initialize' do
		it 'returns an instance of the Game class' do
			expect(game).to be_an_instance_of(Game)
		end

		it 'allows an options hash as a parameter' do
			expect do
				Game.new({})
			end.to_not raise_error
		end

		it 'allows board and player state to be set via options' do
			expect do
				game_state
			end.to_not raise_error
		end

		it 'allows debug to be set via options' do
			expect do
				Game.new(:debug => true)
			end.to_not raise_error
		end
	end

	describe '#player' do
		it 'is an accessor' do
			expect do
				game.player
				game.player = nil
			end.to_not raise_error
		end
	end

	describe '#board' do
		it 'is an accessor' do
			expect do
				game.board
				game.board = nil
			end.to_not raise_error
		end
	end

	describe '#debug' do
		it 'is an accessor' do
			expect do
				game.debug
				game.debug = nil
			end.to_not raise_error
		end
	end

	describe '#to_s' do
		it 'returns a string' do
			expect(game.to_s).to be_kind_of(String)
		end
	end

	describe '#move' do
		it 'accepts a string as the first parameter and integers as the next 2 parameters' do
			expect {game.move('', 1, 1)}.to_not raise_error
		end

		context 'the type is f' do
			it 'calls player#flag' do
				expect(game.player).to receive(:flag)
				game.move('f', 0, 0)
			end
		end

		context 'the type is c' do
			it 'calls #clear' do
				expect(game).to receive(:clear)
				game.move('c', 0, 0)
			end

			it 'auto clears the correct number of squares' do
				game.board.state = [
					'02MMMMMMMM',
					'23MMMMMMMM',
					'MMMMMMMMMM',
					'MMMMMMMMMM',
					'MMMMMMMMMM',
					'MMMMMMMMMM',
					'MMMMMMMMMM',
					'MMMMMMMMMM',
					'MMMMMMMMMM',
					'MMMMMMMMMM'
				]
				game.move('c', 0, 0)
				cleared = game.player.select_coordinates do |x, y|
					game.player.cleared?(x, y)
				end
				expect(cleared.sort).to eq([[0, 0], [1, 1], [0, 1], [1, 0]].sort)
			end
		end
	end

	# 
	# 

	describe '#cheat!' do
		let(:b){game.board.normalize}
		let(:p){game.player.normalize}

		before do
			game.cheat!
		end

		it 'sets the player state to a winning state' do
			expect(game.win?).to eq(true)
		end

		it 'sets every 0 on board to - on player' do
			b.chars.each_with_index do |c, i|
				expect(p[i]).to eq('-') if c == '0'
			end
		end

		it 'sets every integer > 0 to that integer on player' do
			b.chars.each_with_index do |c, i|
				expect(p[i]).to eq(c) if c =~ /[1-9]/
			end
		end

		it 'sets every M on board to F on player' do
			b.chars.each_with_index do |c, i|
				expect(p[i]).to eq('F') if c == 'M'
			end
		end
	end

	describe '#boom!' do
		let(:b){game.board.normalize}
		let(:p){game.player.normalize}

		before do
			game.boom!
		end

		it 'sets the player state to a losing state' do
			expect(game.lose?).to eq(true)
		end

		it 'sets every M on board to M on player' do
			b.chars.each_with_index do |c, i|
				expect(p[i]).to eq('M') if c == 'M'
			end
		end
	end

	describe '#lose?' do
		it 'returns true when the player state is a losing state' do
			game_state.player.state = PLAYER_LOSE_NORMALIZED
			expect(game_state.lose?).to eq(true)
		end

		it 'returns false when the player state is a winning state' do
			expect(game_state.lose?).to eq(false)
		end
	end

	describe '#win?' do
		it 'returns true when the player state is a winning state' do
			expect(game_state.win?).to eq(true)
		end

		it 'returns false when the player state is a losing state' do
			game_state.player.state = PLAYER_LOSE_NORMALIZED
			expect(game_state.win?).to eq(false)
		end
	end
end

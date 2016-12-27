require "mine_sweeper"

describe MineSweeper do

	let(:game) {MineSweeper.new}

	describe '#playing' do

		it 'sets the game attributes properly' do
			expect(game.instance_variable_get(:@board)).not_to be_nil
		end

		it 'generates map for board on start' do
			expect(game.board).to receive(:generate_map)
			game.start
		end

		it 'renders map when game starts' do
			expect(game.board).to receive(:render)
			game.start
		end

		it 'can play game' do
			expect(game.player).to receive(:gets).and_return("open 2 3", "quit")
			game.play
		end

	end

end
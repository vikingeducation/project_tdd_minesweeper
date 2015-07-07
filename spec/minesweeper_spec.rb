require 'minesweeper'


describe Minesweeper do
	let(:new_game){Minesweeper.new}
	let(:blank_board){((0..100).to_a)}

	describe "#initialize" do
		it "creates a Minesweeper object" do
			expect(Minesweeper.new).to be_a(Minesweeper)
		end

	end

	describe "#game" do
		it "sets game difficulty / level" do
			allow(new_game).to receive(:gets).and_return("A")
			expect(new_game.level).to be_an(Array)
		end

		it "creates a Player object" do
			allow(new_game).to receive(:level).and_return([1,2])
			allow(Board).to receive(:new).with(1,2)
			#allow(new_game).to receive(:gets).and_return("A")
			#allow(new_game).to receive(:board).and_return(blank_board)
			expect(Player).to receive(:new).with(Board.new(1,2))
			new_game.game
		end

		it "creates a game board" do
			allow(new_game).to receive(:level).and_return([1,2])
			expect(Board).to receive(:new).with(1,2)
			new_game.game
		end

	end

	describe '#___' do


	end



end

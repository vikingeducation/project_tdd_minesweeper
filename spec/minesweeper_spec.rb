require 'minesweeper'


describe Minesweeper do
	let(:new_game){Minesweeper.new}
	describe "#initialize" do
		it "creates a Minesweeper object" do
			expect(Minesweeper.new).to be_a(Minesweeper)
		end

	end

	describe "#game" do
		it "sets game difficulty / level" do
			allow(new_game).to recieve(:level).and_return("A")
			expect(new_game.level).to be_an(Integer)
		end

		it "creates a Player object" do
			expect(Player.new).to be_a(Player)   #how do we test that a player exists on initialize?
		end

		it "creates a game board" do
		end


	end
end

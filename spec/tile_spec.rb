require 'tile'

describe Tile do
	let(:tile) { Tile.new }
	describe "#initialize" do
		it "does not have a mine" do
			expect(tile.mine).to eq(false)
		end

		it "has contents that are not revealed" do
			expect(tile.is_revealed).to eq(false)
		end

		it "has contents that are not flagged" do
			expect(tile.is_flagged).to eq(false)
		end
	end

	describe "#revealed" do
		it "reveals a tile that is not revealed" do
			tile.revealed
			expect(tile.is_revealed).to eq(true)
		end
	end

	describe "#flagged" do
		it "toggles a flag" do
			tile.flagged
			expect(tile.is_flagged).to eq(true)
		end
	end

	describe "#make_mine" do
		it "makes a mine" do
			tile.make_mine
			expect(tile.mine).to eq(true)
		end
	end
end
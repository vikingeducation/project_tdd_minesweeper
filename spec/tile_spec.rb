require 'tile'

describe Tile do
	let(:tile) { Tile.new }
	describe "#initialize" do
		it "does not have a mine" do
			expect(tile.is_mine).to eq(false)
		end

		it "has contents that are not revealed" do
			expect(tile.is_revealed).to eq(false)
		end

		it "has contents that are not flagged" do
			expect(tile.is_flagged).to eq(false)
		end
	end

	describe "#reveal" do
		it "reveals a tile that is not revealed" do
			tile.reveal
			expect(tile.is_revealed).to eq(true)
		end
	end

	describe "#flag" do
		it "toggles a flag" do
			tile.flag
			expect(tile.is_flagged).to eq(true)
		end
	end

	describe "#make_mine" do
		it "makes a mine" do
			tile.make_mine
			expect(tile.is_mine).to eq(true)
		end
	end
end
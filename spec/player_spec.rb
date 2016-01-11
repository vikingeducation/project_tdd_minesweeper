require 'player'

describe Player do
	let(:player) { Player.new }
	describe "#choose_coords" do
		it "gets the coordinates from the player" do
			allow(player).to receive(:gets).and_return("[5,5]")
			expect(player.choose_coords).to eq([5,5])
		end
	end
end
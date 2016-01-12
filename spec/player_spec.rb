require 'player'

describe Player do
	let(:player) { Player.new }

  describe "#initialize" do
    it "initializes with choice equal to nil" do
      expect(player.choice).to eq(nil)
    end

    it "initializes with kind equal to nil" do
      expect(player.kind).to eq(nil)
    end
  end

	describe "#choose_coords" do
		it "gets the coordinates from the player" do
			allow(player).to receive(:gets).and_return("[5,5]")
			expect(player.choose_coords).to eq([5,5])
		end
	end

  describe "#move_kind" do
    it "chooses the kind of move" do
      allow(player).to receive(:gets).and_return("flag")
      expect(player.move_kind).to eq("flag")
    end
  end


end
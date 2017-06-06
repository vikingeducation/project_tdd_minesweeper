require_relative '../lib/player'

describe Player do

  let(:player) { Player.new }

  describe "#click_selection" do

    it "should ask user for coordinates of square" do
      allow(player).to receive(:gets).and_return("3,2,1")
      expect(player).to receive(:puts)
      player.click_selection
    end

    it "should return array for valid inputs" do
      allow(player).to receive(:gets).and_return("2,3,1")
      expect(player.click_selection).to eq([2,3,1])
    end

    it "should check if #inputs_valid?" do
      allow(player).to receive(:gets).and_return("2,3,1")
      expect(player).to receive(:inputs_valid?).with([2,3,1]).and_return(true)
      player.click_selection

    end

    context "#inputs_valid? returns false" do

      it "should raise error that inputs were invalid" do
        allow(player).to receive(:inputs_valid?).and_return(false)
        expect{player.click_selection}.to raise_error("That is not a valid input")
      end

    end

  end

  describe "#inputs_valid?" do

    it "should return true for valid inputs" do
      expect(player.inputs_valid?([9,0,1])). to be true
    end

    it "should return false for invalid inputs" do
      expect(player.inputs_valid?([10,2,5])).to be false
    end

  end

end

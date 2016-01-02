require 'player'

describe Player do

  let(:board){double("board", :place_players_move => "nil")}

  let(:player){Player.new(board)}

  it 'should be an instance of class' do
    expect(player).to be_a(Player)
  end

  describe '#turn' do
    it "calls the board classes' method #place_players_move" do
      allow(player).to receive(:get_response).and_return(true)
      expect(board).to receive(:place_players_move)
      player.turn
    end

    it "calls the #get_response method" do
      expect(player).to receive(:get_response).and_return(true)
      player.turn
    end
  end

  describe '#get_response' do
    it 'calls the #gets method' do
      allow(player).to receive(:response_is_valid?).and_return(true)
      expect(player).to receive(:gets).and_return("Tszyu")
      player.get_response
    end

    it 'calls the #response_is_valid? method' do
      allow(player).to receive(:gets).and_return("Tszyu")
      allow(player).to receive(:response_is_valid?).and_return(true)
      expect(player).to receive(:response_is_valid?).and_return(true)
      player.get_response
    end

    it 'returns the response variable' do
      allow(player).to receive(:gets).and_return("Tszyu")
      allow(player).to receive(:response_is_valid?).and_return(true)
      expect(player.get_response).to eq("tszyu")
    end
  end

  describe '#response_is_valid?' do
    it "returns true if response is 'q'" do
      expect(player.response_is_valid?('q')).to eq(true)
    end

    it "returns true if response is valid" do
      expect(player.response_is_valid?('o33')).to eq(true)
    end

    it "returns false if response doesn't have 3 characters in it" do
      expect(player.response_is_valid?('o343')).to eq(false)
    end

    it "returns false if response doesn't have 3 characters in it" do
      expect(player.response_is_valid?('43')).to eq(false)
    end

    it "returns false if the first character of response isn't a o or f" do
      expect(player.response_is_valid?('m43')).to eq(false)
    end

    it "returns false if the second character of response isn't a number" do
      expect(player.response_is_valid?('mr3')).to eq(false)
    end

    it "returns false if the second character of response isn't a number" do
      expect(player.response_is_valid?('m3t')).to eq(false)
    end
  end

end
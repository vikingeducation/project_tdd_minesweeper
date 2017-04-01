require 'player'
describe Player do
  let(:player) {Player.new('Ann')}
  describe '#init' do
    it 'creates player with name' do
      expect(player.name).to eq('Ann')
    end
  end

end

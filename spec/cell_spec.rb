require 'cell'
describe Cell do
  let(:cell) {Cell.new(false)}
  describe '#init' do
    it 'creates a new cell' do
      expect(cell).to be_a(Cell)
    end
    it 'has an is_mine property' do
      expect(cell.is_mine).to be(false)
    end
    it 'has an adj_mine_count property' do
      expect(cell).to have_attributes(:adj_mine_count => (a_value < 9))
    end
    it 'has a boolean revealed state' do
      expect(cell.revealed).to be(false)
    end
    it 'has a boolean flagged state' do
      expect(cell.flagged).to be(false)
    end
    it 'has an initial value symbol' do
      expect(cell.value_sym).to eq(:X)
    end
    it 'has an initial render symbol' do
      expect(cell.render_sym).to eq(:S)
    end
    it 'has a color' do

      expect(cell.color).to eq(:white)
    end
  end

  describe 'update_value' do

  end
end

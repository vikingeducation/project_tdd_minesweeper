RSpec.describe Cell do
  describe 'mine count' do
    let(:mine_field) { MineField.new(width: 4, mine_count: 0) }

    before do
      mine_field.find(1, 2).set_mine
      mine_field.find(2, 1).set_mine
    end

    it 'knows it' do
      cell = mine_field.find(1, 1)
      expect(cell.mine_count).to eq 2
    end

    it 'displays it when cleared' do
      cell = mine_field.find(1, 1)
      expect(cell.contents).to eq '?'

      cell.clear
      expect(cell.contents).to eq cell.mine_count.to_s
    end
  end
end
require 'cell'

describe Cell do

  let(:cell) { Cell.new }
  describe '#initialize' do
    it 'defaults to correct attributes when passed nothing' do
      expect(cell.value).to eq(0)
      expect(cell.is_a_mine).to be false
      expect(cell.is_visible?).to be false
      expect(cell.adjacent_mines).to eq(0)
      expect(cell.flagged).to be false
    end
  end

  describe '#icon' do
    it 'returns a bomb icon when @is_a_mine and @is_visible are true' do
      cell.mine_henshin
      cell.toggle_visibility
      expect(cell.icon).to eq('💣')
    end
    it 'returns a flag icon when @flagged is true' do
      cell.toggle_flag
      expect(cell.icon).to eq('⚑')
    end
    it 'returns a square icon when @is_visible is false' do
      expect(cell.icon).to eq('❏')
    end
    it 'returns a checkmark icon if @value is equal to zero' do
      cell.toggle_visibility
      expect(cell.icon).to eq('✓')
    end
  end

end
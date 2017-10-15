require 'cell'
require 'icon'

describe Cell do
  include Icon

  let(:cell) { Cell.new }

  describe '#initialize' do
    it("is a Cell") { expect(cell).to be_a(Cell) }
    it("has a default value of 0") { expect(cell.value).to eq(0) }
    it("is hidden by default") { expect(cell.visible).to eq(false) }
  end

  describe 'when a user selects this cell' do
    it 'checks to see if it is a mine'
    it 'clears all neighboring 0 value cells'
    it 'displays the value of the cell' do
      cell.value = 3
      cell.visible = true
      expect(cell.to_s.to_i).to eq(3)
    end
    describe 'for a flag' do
      it 'does not allow more than one flag per cell'
      it 'if a flag is already there, it will be removed and the flag count will be restored'
      it 'displays a flag icon' do
        expect(cell.flag).to eq("#{Icon::FLAG}")
      end
    end
  end

  describe 'when it has not been clicked' do
    it 'displays a dot' do
      cell.visible = false
      expect(cell.to_s).to eq("#{Icon::HIDDEN}")
    end
  end

end

describe Mine do
  let(:mine) { Mine.new }

  it("is a subclass of Cell") { expect(mine).to be_a(Cell) }

  describe 'when it has not been clicked' do
    it 'displays a dot' do
      mine.visible = false
      expect(mine.to_s).to eq("#{Icon::HIDDEN}")
    end
  end

  describe 'when it has been clicked' do
    it 'displays a mine icon' do
      mine.visible = true
      expect(mine.to_s).to eq("#{Icon::MINE}")
    end
  end

end
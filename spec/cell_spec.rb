require 'cell'
require 'icon'

describe Cell do
  include Icon

  let(:cell) { Cell.new }

  describe '#initialize' do
    it("is a Cell") { expect(cell).to be_a(Cell) }
    it("has a default value of 0") { expect(cell.value).to eq(0) }
    it("is hidden by default") { expect(cell.revealed?).to eq(false) }
  end

  describe '#to_s' do
    it 'displays the value of the cell' do
      cell.value = 3
      expect(cell.to_s.to_i).to eq(3)
    end
  end

  describe '#flag' do
    it 'displays a flag icon + a space' do
      expect(cell.flag).to eq("#{Icon::FLAG} ")
    end
  end

end

describe Mine do
  let(:mine) { Mine.new }

  it("is a subclass of Cell") { expect(mine).to be_a(Cell) }

  describe '#to_s' do
    it 'displays a mine icon + a space' do
      expect(mine.to_s).to eq("#{Icon::MINE} ")
    end
  end

end
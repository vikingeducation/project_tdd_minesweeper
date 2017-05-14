require 'rspec'
require 'cell'

describe Cell do
  c = Cell.new

  describe '#initialize' do
    it 'creates a cell' do
      expect(c).to be_a(Cell)
    end
    it 'does not have a mine by default' do
      expect(c.mine).to eq(false)
    end
    it 'is not marked by default' do
      expect(c.marked).to eq(false)
    end
    it 'is not cleared by default' do
      expect(c.cleared).to eq(false)
    end
    it 'is not near any mines by default' do
      expect(c.near_mines).to eq(0)
    end

    describe '#plant_mine' do
      it 'plants a mine' do
        expect(c.mine).to eq(false)
        c.plant_mine
        expect(c.mine).to eq(true)
      end
    end

    describe '#clear' do
      it 'clears the mine' do
        expect(c.cleared).to eq(false)
        c.clear
        expect(c.cleared).to eq(true)
      end
    end

    describe '#mark_mine' do
      it 'marks the cell as having a mine' do
        expect(c.marked).to eq(false)
        c.mark_mine
        expect(c.marked).to eq(true)
      end
    end
  end
end

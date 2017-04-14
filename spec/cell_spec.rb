require 'cell'

describe Cell do
  let(:cell) { Cell.new }
  describe ' #initialize ' do
    it ' creates a cell with no bomb, no flag, and cover on ' do
      expect(cell.bomb).to eq(false)
      expect(cell.flag).to eq(false)
      expect(cell.cover).to eq(true)
    end
  end

  describe ' #flag= ' do
    it ' sets the flag to true ' do
      cell.flag=(true)
      expect(cell.flag).to eq(true)
    end

    it ' renders as a flag when true ' do
      cell.flag=(true)
      expect(cell.render).to eq('|')
    end
  end

  describe ' #cover= ' do
    it ' sets the cover to false ' do
      cell.cover=(false)
      expect(cell.cover).to eq(false)
    end

    it ' renders as uncovered when false and no flag ' do
      cell.cover=(false)
      expect(cell.render).to eq('_')
    end

    it ' renders as covered when true ' do
      cell.cover=(true)
      expect(cell.render).to eq('O')
    end
  end

  describe ' #adjacent_bombs= ' do
    it ' renders the number of adjacents when set and not covered ' do
      cell.adjacent_bombs=(4)
      cell.cover=(false)
      expect(cell.render).to eq('4')
    end
  end
end

require 'cell'

describe Cell do

  let(:cell){ Cell.new }

  describe '#new' do
    it 'is initialized with mine? false' do
      expect(cell.mine?).to be false
    end
    it 'is initialized with cleared? false' do
      expect(cell.cleared?).to be false
    end
    it 'is initialized with flagged? false' do
      expect(cell.flagged?).to be false
    end
    it 'is initialized with adjacent_mines equal to zero' do
      expect(cell.adjacent_mines).to be 0
    end
  end

  describe '#place_mine' do
    before(:each) do
      cell.place_mine
    end
    it 'adds a mine to the cell' do
      expect(cell.mine?).to be true
    end
  end

  describe '#count_adjacent_mine' do
    it 'adds to the count' do
      cell.count_adjacent_mine
      expect(cell.adjacent_mines).to eq 1
    end
    it 'accepts multiple neighboring mines' do
      4.times { cell.count_adjacent_mine }
      expect(cell.adjacent_mines).to eq 4
    end
  end

  describe '#clear' do
    describe 'without a mine' do
      it 'clears the cell if there is no flag' do
        cell.clear
        expect(cell.cleared?).to be true
      end
      it 'does nothing if the cell has a flag' do
        cell.flag
        cell.clear
        expect(cell.cleared?).to be false
      end
    end
    describe 'with a mine' do
      before(:each) do
        cell.place_mine
      end
      it 'explodes if there is no flag' do
        cell.clear
        expect(cell.exploded?).to be true
      end
      it 'does not explode if there is a flag' do
        cell.flag
        cell.clear
        expect(cell.exploded?).to be false
      end
    end
  end

  describe '#flag' do
    it 'flags the cell' do
      cell.flag
      expect(cell.flagged?).to be true
    end
    it 'does not work if the cell is cleared' do
      cell.clear
      cell.flag
      expect(cell.flagged?).to be false
    end
  end

  describe '#to_s' do
    describe 'for cleared states' do
      it 'displays a mine (✷) if exploded' do
        cell.place_mine
        cell.clear
        expect(cell.to_s).to eq "✷"
      end
      it 'displays a space ( ) if there are no adjacent mines' do
        cell.clear
        expect(cell.to_s).to eq " "
      end
      it 'displays the number of adjacent mines if there are any' do
        4.times { cell.count_adjacent_mine }
        cell.clear
        expect(cell.to_s).to eq "4"
      end
    end
    describe 'for un-cleared states' do
      it 'displays a solid box (█) without a flag' do
        expect(cell.to_s).to eq "█"
      end
      it 'displays a flag (⚑) with a flag' do
        cell.flag
        expect(cell.to_s).to eq "⚑"
      end
    end
  end
end
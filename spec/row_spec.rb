require 'row'
require 'cell'

describe Row do
  let(:board_size) { 10 }
  let(:row) { Row.new }

  describe '#build' do
    it 'builds a row of cells equal to the board size' do
      expect(row.build(board_size).length).to eq(board_size)
    end

    it 'contains 1 mine per row' do
      mines = row.build(board_size).select do |cell|
        cell.is_a?(Mine)
      end
      expect(mines.length).to eq(1)
    end
  end

end
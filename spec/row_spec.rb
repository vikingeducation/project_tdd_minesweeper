require 'row'
require 'cell'

describe Row do

  describe '#build' do
    it 'builds a row of cells with unique object ids' do
      row = Row.new
      unique_cells = row.uniq
      expect(row.length).to eq(unique_cells.length)
    end
  end

end
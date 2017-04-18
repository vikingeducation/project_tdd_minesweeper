RSpec.describe MineField do
  let(:mine_field) { MineField.new(width: 10, mine_count: 9) }

  it 'is 10x10 by default' do
    expect(mine_field.size).to eq 100
  end

  it 'is filled with cells' do
    expect(mine_field.find(1, 1)).to be_a Cell
  end

  it 'has 10 mines in its minefield by default' do
    expected_mine_count = 0

    mine_field.each { |cell| expected_mine_count += 1 if cell.mined? }
    expect(expected_mine_count).to eq 9
  end

  describe 'coordinates' do
    let(:cell1) { mine_field.find(1, 1) }
    let(:cell11) { mine_field.find(2, 1) }

    context 'first row' do
      it 'has x coordinate of 1' do
        cell10 = mine_field.find(1, 9)

        expect(cell1.coordinates[:x]).to eq 1
        expect(cell10.coordinates[:x]).to eq 1
      end
    end

    context 'second row' do
      it 'has x coordinate of 2' do
        cell20 = mine_field.find(2, 10)

        expect(cell11.coordinates[:x]).to eq 2
        expect(cell20.coordinates[:x]).to eq 2
      end
    end

    context 'columns' do
      it 'has y coordinates in ascending order for each row' do
        cell2 = mine_field.find(1, 2)
        cell12 = mine_field.find(2, 2)

        expect(cell1.coordinates[:y]).to eq 1
        expect(cell2.coordinates[:y]).to eq 2
        expect(cell11.coordinates[:y]).to eq 1
        expect(cell12.coordinates[:y]).to eq 2
      end
    end
  end

  describe 'assigning neighbors' do
    it 'assigns 3 neighbors to a corner cell' do
      corner_cell = mine_field.find(1, 10)
      expect(corner_cell.neighbors.size).to eq 3
    end

    it 'assigns 8 neighbors to a middle cell' do
      cell = mine_field.find(2, 4)
      expect(cell.neighbors.size).to eq 8
    end

    it 'assigns correct neighbors to cell' do
      corner_cell = mine_field.find(1, 10)
      expected_neighbors = [
        mine_field.find(1, 9).coordinates,
        mine_field.find(2, 10).coordinates,
        mine_field.find(2, 9).coordinates
      ]

      neighbor_coords = corner_cell.neighbors.map { |cell| cell.coordinates }

      neighbor_coords.each do |nc|
        expect(expected_neighbors).to include nc
      end
    end
  end

end
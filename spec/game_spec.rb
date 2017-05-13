require 'rspec'
require 'game'
require 'cell'

describe Game do
  g = Game.new
  describe "initialize" do
    it 'creates a board' do
      expect(g.board).to be_a(Board)
    end
    it 'does other stuff'
  end

  describe 'play' do
    it 'calls'
  end

  describe 'get_coordinates' do
    it 'returns an array containing coordinates' do
      allow(g).to receive(:gets).and_return("0,0")
      expect(g.get_coordinates).to eq([0,0])
    end
    it 'returns an array' do
      allow(g).to receive(:gets).and_return("09")
      expect(g.get_coordinates).to eq([9])
    end
  end

  describe 'valid_coordinates' do
    it 'returns true if input in correct format' do
      expect(g.valid_coordinates([1,1])).to eq(true)
    end

    it 'returns false if input does not conform' do
      expect(g.valid_coordinates([1,-1])).to eq(false)
    end

    it 'is false if selection outside of the board' do
      expect(g.valid_coordinates([11,0])).to eq(false)
    end

    it 'returns false if input is not an array of 2' do
      expect(g.valid_coordinates([0])).to eq(false)
    end
  end

  describe 'valid_move' do
    it 'returns true if c for clear' do
      expect(g.valid_move("C")).to eq(true)
    end

    it 'returns false if not c or m' do
      expect(g.valid_move("2")).to eq(false)
    end
  end

  mock_game = Game.new
  # mock_game.board.board_a = Array.new(3) {Array.new(3) {Cell.new}}
  test_cell = mock_game.board.board_a[0][0]

  describe 'execute move' do
    it 'clears cell if C' do
      expect(test_cell.cleared).to eq(false)
      puts "The board before"
      mock_game.render.render_board
      mock_game.execute_move([0,0,"C"])
      mock_game.render.render_board
      expect(test_cell.cleared).to eq(true)
    end

    it 'decrements the number of flags by one if m' do
      mock_game.execute_move([0,0,"M"])
      expect(mock_game.board.num_flags).to eq(8)
    end

    it 'unmarks mine if already marked' do
      mock_game.execute_move([0,0,"M"])
      expect(test_cell.marked).to eq(false)
    end

    it 'marks flag if m' do
      test_cell = mock_game.board.board_a[1][0]
      expect(test_cell.marked).to eq(false)
      mock_game.execute_move([0,1,"M"])
      expect(test_cell.marked).to eq(true)
    end
  end

end

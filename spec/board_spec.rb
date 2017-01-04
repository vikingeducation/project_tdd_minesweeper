require 'board'
require 'render' 

describe Board do
  let(:default_board) { Board.new }
  let(:custom_board) { Board.new(width: 16, mines: 40) }
  let(:custom_board_2) { Board.new(width: 5, mines: 5, mines_array: [[0,2],[1,1],[1,3],[2,2],[4,4]]) }

  describe '#initialize' do 
    it 'should create a default board of size 10x10 with 9 mines (flags)' do
      expect(default_board.board.size).to eq(10)
      default_board.board.each do |row|
        expect(row.size).to eq(10)
      end
      expect(default_board.flags).to eq(9)
    end

    it 'should create a board with the specified width and mines (flags)' do
      expect(custom_board.board.size).to eq(16)
      custom_board.board.each do |row|
        expect(row.size).to eq(16)
      end
      expect(custom_board.flags).to eq(40)
    end

    it 'should raise an error if too many mines are specified' do
      expect{ Board.new(width: 25, mines: 188) }.to raise_error('Too many mines! (max 30% of area)')
    end

    it 'should generate a mines array containing locations of mines' do
      expect(default_board.mines_array.size).to eq(9)
      expect(default_board.mines_array).to be_an(Array)
      expect(default_board.mines_array[0]).to be_an(Array)
      expect(default_board.mines_array[0].size).to eq(2)
    end

    it 'should create a board with cells that have status of uncleared and position [x, y]' do
      default_board.board.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          expect(cell).to be_an(Cell)
          expect(cell.status).to eq('uncleared')
          expect(cell.position).to eq([x, y])
        end
      end
    end

    it 'should populate the board with mines' do
      default_board.mines_array.each do |mine|
        expect(default_board.board[mine[1]][mine[0]].mine).to eq(true)
      end
      expect(custom_board_2.board[2][0].mine).to eq(true)
    end

    it 'should create an adjacent_mines_array that contains the num of adj mines for corresponding cell' do
      expect(custom_board_2.adjacent_mines_array).to eq(
        [ [1, 1, 1, 0, 0],
          [2, nil, 2, 1, 0],
          [nil, 4, nil, 1, 0],
          [2, nil, 2, 2, 1],
          [1, 1, 1, 1, nil]
        ]
      )
    end
  end

  describe '#valid_move?' do
    let(:move1) { 'abcd' }
    let(:move2) { 'a b d'}
    let(:move3) { '11 b c'}
    let(:move4) { '5 0 c'}
    let(:move5) { '4 6 c'}  # clear
    let(:move6) { '3 5 f'}  # flag
    let(:move7) { '2 4 u'}  # unflag

    it 'should return false if move is in the wrong format' do
      expect(default_board.valid_move?(move1)).to eq(false)
    end

    it 'should return false if move does not contain the right action (c, f, u)' do
      expect(default_board.valid_move?(move2)).to eq(false)
    end

    it 'should return false if x pos of move is out of range' do
      expect(default_board.valid_move?(move3)).to eq(false)
    end 

    it 'should return false if y pos of move is out of range' do
      expect(default_board.valid_move?(move4)).to eq(false)
    end 

    it 'should return false for a flag move if there are no flags remaining' do
      default_board.flags = 0
      expect(default_board.valid_move?(move6)).to eq(false)
    end

    it 'should return false if action is not valid at cell' do
      default_board.board[5][3].status = 'cleared'
      expect(default_board.valid_move?(move5)).to eq(false)
      default_board.board[4][2].status = 'cleared'
      expect(default_board.valid_move?(move6)).to eq(false)
      default_board.board[3][1].status = 'cleared'
      expect(default_board.valid_move?(move7)).to eq(false)
    end

    it 'should return true if move is valid' do
      default_board.board[5][3].status = 'uncleared'
      expect(default_board.valid_move?(move5)).to eq(true)
      default_board.board[4][2].status = 'uncleared'
      expect(default_board.valid_move?(move6)).to eq(true)
      default_board.board[3][1].status = 'flagged'
      expect(default_board.valid_move?(move7)).to eq(true)
    end
  end

  describe '#update_board!' do
    it 'should properly update the status and display of a cell if move flags a cell' do
      custom_board_2.update_board!('5 1 f')
      expect(custom_board_2.board[0][4].status).to eq('flagged')
      expect(custom_board_2.board[0][4].display).to eq(Render::FLAG)  ## ??
    end

    it 'should reduce the number of flags by one if move flags a cell' do
      custom_board_2.update_board!('5 1 f')
      expect(custom_board_2.flags).to eq(4)
    end

    it 'should properly update the status and display of a cell if move unflags a cell' do
      custom_board_2.board[1][2].status = 'flagged' 
      custom_board_2.update_board!('3 2 u')
      expect(custom_board_2.board[0][4].status).to eq('uncleared')
      expect(custom_board_2.board[0][4].display).to eq(Render::EMPTY_CELL)
    end

    it 'should increase the number of flags by one if move unflags a cell' do
      custom_board_2.board[1][2].status = 'flagged' 
      custom_board_2.update_board!('3 2 u')
      expect(custom_board_2.flags).to eq(6)
    end

    it 'should properly update the status and display of cells if move clears a mine' do
      custom_board_2.update_board!('2 2 c')
      expect(custom_board_2.board[1][1].status).to eq('cleared')
      expect(custom_board_2.board[1][1].display).to eq(Render::BOMB_RB)
      # filter first, then run .each
      custom_board_2.mines_array.each do |mine|
        unless mine == [1, 1]
          expect(custom_board_2.board[mine[1]][mine[0]].display).to eq(Render::BOMB)
        end
      end
    end

    it 'should properly update the status and display of cells if move clears a cell with adjacent mines' do
      custom_board_2.update_board!('2 3 c')
      expect(custom_board_2.board[2][1].status).to eq('cleared')
      expect(custom_board_2.board[2][1].display).to eq(Render.cleared_cell(4))
      custom_board_2.board[1..3].each do |row|
        row[0..2].each do |cell|
          unless cell.position == [1, 2]
            expect(cell.status).to eq('uncleared')
            expect(cell.display).to eq(Render::EMPTY_CELL)
          end
        end
      end
    end

    it 'should properly update the status and display of cells if move clears a cell with no adj mines' do
      custom_board_2.update_board!('5 1 c')
      expect(custom_board_2.board[0][4].status).to eq('cleared')
      expect(custom_board_2.board[0][4].display).to eq(Render::CLEARED_CELL)
      zero_adj_mines = [[3, 0], [4, 1], [4, 2]]
      zero_adj_mines.each do |pos|
        expect(custom_board_2.board[pos[1]][pos[0]].status).to eq('cleared')
        expect(custom_board_2.board[pos[1]][pos[0]].display).to eq(Render::CLEARED_CELL)
      end
      one_adj_mines = [[2, 0], [3, 1], [3, 2], [4, 3]]
      one_adj_mines.each do |pos|
        expect(custom_board_2.board[pos[1]][pos[0]].status).to eq('cleared')
        expect(custom_board_2.board[pos[1]][pos[0]].display).to eq(Render.cleared_cell(1))
      end
      two_adj_mines = [[2, 1], [3, 3]]
      two_adj_mines.each do |pos|
        expect(custom_board_2.board[pos[1]][pos[0]].status).to eq('cleared')
        expect(custom_board_2.board[pos[1]][pos[0]].display).to eq(Render.cleared_cell(2))
      end
      all_positions = []
      (0..4).each do |x|
        (0..4).each do |y|
          all_positions << [x, y]
        end
      end
      remaining_cells = all_positions - [[4, 0]] -  zero_adj_mines - one_adj_mines - two_adj_mines
      remaining_cells.each do |pos|
        expect(custom_board_2.board[pos[1]][pos[0]].status).to eq('uncleared')
        expect(custom_board_2.board[pos[1]][pos[0]].display).to eq(Render::EMPTY_CELL)
      end
    end

    # time cop gem
    it 'should properly update the win time if game is won' do
      gg = Board.new(mines_array: [[0,0]])
      sleep(1)
      gg.update_board!('5 5 c')
      expect(gg.win_time).to eq(1)
    end
  end

  describe '#return_board_status' do
    it 'should return ongoing if game has not been lost or won' do
      expect(custom_board_2.return_board_status).to eq('ongoing')
    end

    it 'should return lost if a mine has been cleared' do
      custom_board_2.update_board!('2 2 c')
      expect(custom_board_2.return_board_status).to eq('lost')
    end

    it 'should return won if all non-mine cells have been cleared' do
      custom_board_2.board.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          cell.status = 'cleared' unless cell.mine
        end
      end
      expect(custom_board_2.return_board_status).to eq('won')
    end

    it 'should return lost if time has run out' do
      gg = Board.new(time_limit: 1)
      sleep(1)
      expect(gg.return_board_status).to eq('lost')
    end
  end
end
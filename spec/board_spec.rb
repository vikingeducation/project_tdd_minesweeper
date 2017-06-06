require_relative '../lib/board'

describe Board do

  let(:board) { Board.new }

  let(:mine_hash) { {1 => [0,1], 2 => [1,9], 3 => [2,2], 4 => [3,8], 5 => [5,5],
                     6 => [6,7], 7 => [7,3], 8 => [8,0], 9 => [8,5]} }

  let(:blank_board) { [ ["-","-","-","-","-","-","-","-","-","-"],
                        ["-","-","-","-","-","-","-","-","-","-"],
                        ["-","-","-","-","-","-","-","-","-","-"],
                        ["-","-","-","-","-","-","-","-","-","-"],
                        ["-","-","-","-","-","-","-","-","-","-"],
                        ["-","-","-","-","-","-","-","-","-","-"],
                        ["-","-","-","-","-","-","-","-","-","-"],
                        ["-","-","-","-","-","-","-","-","-","-"],
                        ["-","-","-","-","-","-","-","-","-","-"],
                        ["-","-","-","-","-","-","-","-","-","-"]
                        ]}

  let(:one_cleared_board) {[ ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-"," ","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"]
                           ]}

  let(:partial_with_flags) { Board.new([ [" "," "," ","-","-","-","-","-","$","-"],
                                         [" "," "," ","-","-","-","-","-","-","-"],
                                         [" "," "," ","-","-","-","-","-","-","-"],
                                         [" "," "," ","-","$","-","-","-","-","-"],
                                         ["-","-","-","-","-","-","-","-","-","-"],
                                         ["-","-","-","-","-","-","-","-","-","-"],
                                         ["-","-","-","-","-","$","-","-","-","-"],
                                         ["-","-","-","-","-","-","-","-","-","-"],
                                         ["-","-","-","-","-","-","-","-"," "," "],
                                         ["-","-","-","-","-","-","-","-"," "," "]
                                         ])}

   let(:win_board) { Board.new([ [" ","-"," "," "," "," "," "," "," "," "],
                                 [" "," "," "," "," "," "," "," "," ","-"],
                                 [" "," ","-"," "," "," "," "," "," "," "],
                                 [" "," "," "," "," "," "," "," ","-"," "],
                                 [" "," "," "," "," "," "," "," "," "," "],
                                 [" "," "," "," "," ","-"," "," "," "," "],
                                 [" "," "," "," "," "," "," ","-"," "," "],
                                 [" "," "," ","-"," "," "," "," "," "," "],
                                 ["-"," "," "," "," ","-"," "," "," "," "],
                                 [" "," "," "," "," "," "," "," "," "," "]
                               ]) }

  let(:mine_board) { [ ["-","*","-","-","-","-","-","-","-","-"],
                       ["-","-","-","-","-","-","-","-","-","*"],
                       ["-","-","*","-","-","-","-","-","-","-"],
                       ["-","-","-","-","-","-","-","-","*","-"],
                       ["-","-","-","-","-","-","-","-","-","-"],
                       ["-","-","-","-","-","*","-","-","-","-"],
                       ["-","-","-","-","-","-","-","*","-","-"],
                       ["-","-","-","*","-","-","-","-","-","-"],
                       ["*","-","-","-","-","*","-","-","-","-"],
                       ["-","-","-","-","-","-","-","-","-","-"]
                     ] }

  describe "#initialize" do

    it "should create a blank 10 X 10 board structure" do
      expect(board.game_board).to eq(Array.new(10, Array.new(10, "-")))
    end

    it "should start with 9 flags" do
      expect(board.number_flags).to eq(9)
    end

  end

  describe "#hide_mines" do

    let(:mine_hash) { board.hide_mines}

    it "should return a hash with coordinates" do
      expect(mine_hash).to be_a_kind_of(Hash)
    end

    context "return hash" do

      it "should have 9 keys" do
        expect(mine_hash.keys.count).to eq(9)
      end

      context "each key value" do

        it "should be an array with two elements" do
          expect(mine_hash[1].size).to eq(2)
        end

        context "each array element" do

          it "should be an integer" do
            expect(mine_hash[3][0]).to be_a_kind_of(Integer)
          end

        end

      end

    end

    it "should not actually place mines on board, they are hidden from user" do
      board.hide_mines
      expect(board.render_board).to eq(blank_board)
    end


  end


  # describe "#render_board" do
  #
  #   it "should render blank board at beginning of game" do
  #     expect(board.render_board).to eq(blank_board)
  #   end
  #
  #   context "when a flag is placed" do
  #
  #     it "should render any flags that have been placed" do
  #     end
  #
  #     it "should render number of remaining flags after flag has been placed" do
  #     end
  #
  #   end
  #
  #   context "when a square is cleared" do
  #
  #     it "should render that square cleared" do
  #     end
  #
  #     context "it has no close mines" do
  #
  #       it "should render the cleared square blank" do
  #       end
  #
  #     end
  #
  #     context "it is touching a(/other) mine(s)" do
  #
  #       it "should display number of mines it is touching" do
  #       end
  #
  #     end
  #
  #   end
  #
  # end

  describe "#click_square" do

    context "given coordinates from player" do

      it "changes square from available('-') to cleared(' ')" do
        board.click_square([3, 5, 1], mine_hash)
        expect(board.render_board).to eq(one_cleared_board)
      end

      context "square contains a mine" do

        it "should reveal all mines on board" do
          coords = [2,2,1]
          board.click_square(coords, mine_hash)
          expect(board.render_board).to eq(mine_board)
        end

      end

      context "player specifies coordinates are to place flag(2)" do

        it "should call #place_flag on board" do
          coords = [0,1,2]
          expect(board).to receive(:place_flag).with([coords[0],coords[1]])
          board.click_square(coords, mine_hash)
        end

        it "should place a flag('$') instead of clear the square('')" do
          coords = [0,1,2]
          board.click_square(coords, mine_hash)
          expect(board.render_board).to eq([ ["-","$","-","-","-","-","-","-","-","-"],
                                             ["-","-","-","-","-","-","-","-","-","-"],
                                             ["-","-","-","-","-","-","-","-","-","-"],
                                             ["-","-","-","-","-","-","-","-","-","-"],
                                             ["-","-","-","-","-","-","-","-","-","-"],
                                             ["-","-","-","-","-","-","-","-","-","-"],
                                             ["-","-","-","-","-","-","-","-","-","-"],
                                             ["-","-","-","-","-","-","-","-","-","-"],
                                             ["-","-","-","-","-","-","-","-","-","-"],
                                             ["-","-","-","-","-","-","-","-","-","-"]
                                             ])
        end

      end

      context "player specifies coordinates are to remove a flag(2)" do

        coords = [5,3,2]
        board = Board.new([ ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","$","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"],
                             ["-","-","-","-","-","-","-","-","-","-"]
                             ])

        it "should call #remove_flag method" do
          expect(board).to receive(:remove_flag).with([coords[0], coords[1]])
          board.click_square(coords, mine_hash)
        end

      end

      context "square is touching a mine" do

        it "should call #reveal_number method" do
          expect(board).to receive(:reveal_number)
          board.click_square( [0, 2, 1], mine_hash)
        end

        it "should reveal the number of mines that square is touching when cleared" do
           board.click_square( [0, 2, 1], mine_hash )
           expect(board.render_board).to eq([ ["-","-","1","-","-","-","-","-","-","-"],
                                              ["-","-","-","-","-","-","-","-","-","-"],
                                              ["-","-","-","-","-","-","-","-","-","-"],
                                              ["-","-","-","-","-","-","-","-","-","-"],
                                              ["-","-","-","-","-","-","-","-","-","-"],
                                              ["-","-","-","-","-","-","-","-","-","-"],
                                              ["-","-","-","-","-","-","-","-","-","-"],
                                              ["-","-","-","-","-","-","-","-","-","-"],
                                              ["-","-","-","-","-","-","-","-","-","-"],
                                              ["-","-","-","-","-","-","-","-","-","-"]
                                              ])
        end

      end

    end

  end

  describe "#place_flag" do

    let(:game) { MineSweeper.new }
    let(:flag_coordinates) { [3,4] }

    context "given coordinates from player" do

      it "should place a flag('$') on the board" do
        game.game_board.place_flag(flag_coordinates)
        expect(game.game_board.render_board).to eq([ ["-","-","-","-","-","-","-","-","-","-"],
                                                     ["-","-","-","-","-","-","-","-","-","-"],
                                                     ["-","-","-","-","-","-","-","-","-","-"],
                                                     ["-","-","-","-","$","-","-","-","-","-"],
                                                     ["-","-","-","-","-","-","-","-","-","-"],
                                                     ["-","-","-","-","-","-","-","-","-","-"],
                                                     ["-","-","-","-","-","-","-","-","-","-"],
                                                     ["-","-","-","-","-","-","-","-","-","-"],
                                                     ["-","-","-","-","-","-","-","-","-","-"],
                                                     ["-","-","-","-","-","-","-","-","-","-"]
                                                     ])
        game.game_board.render_board
      end

    end

    it "should reduce the number of remaining flags by 1" do
      expect{game.game_board.place_flag(flag_coordinates)}.to change {game.game_board.number_flags}.from(9).to(8)
    end

    it "should raise an error if they are out of flags" do
      game.game_board.instance_variable_set(:@number_flags, 0)
      expect{game.game_board.place_flag(flag_coordinates)}.to raise_error("You are out of flags!")
    end

  end

  describe "#remove_flag" do

    let(:coords) { [5, 3] }
    let(:board) { Board.new([ ["-","-","-","-","-","-","-","-","-","-"],
                         ["-","-","-","-","-","-","-","-","-","-"],
                         ["-","-","-","-","-","-","-","-","-","-"],
                         ["-","-","-","-","-","-","-","-","-","-"],
                         ["-","-","-","-","-","-","-","-","-","-"],
                         ["-","-","-","$","-","-","-","-","-","-"],
                         ["-","-","-","-","-","-","-","-","-","-"],
                         ["-","-","-","-","-","-","-","-","-","-"],
                         ["-","-","-","-","-","-","-","-","-","-"],
                         ["-","-","-","-","-","-","-","-","-","-"]
                         ]) }

    context "given coordinates from player" do

      it "should remove the flag('$') and return it to original state('-')" do
        board.instance_variable_set(:@number_flags, 8)
        board.remove_flag([coords[0], coords[1]])
        expect(board.render_board).to eq(blank_board)
      end

      it "should add one flag back to the remaining number of flags" do
        board.instance_variable_set(:@number_flags, 8)
        expect{board.remove_flag([coords[0], coords[1]])}.to change {board.number_flags}.from(8).to(9)
      end

      it "should raise an error if number of flags is already 9" do
        board.instance_variable_set(:@number_flags, 9)
        expect{board.remove_flag([coords[0],coords[1]])}.to raise_error("You have no flags to remove!")
      end

      it "should raise an error if there is no flag in that square" do
        board.instance_variable_set(:@number_flags, 8)
        expect{board.remove_flag([3,2])}.to raise_error
      end

    end

  end


  describe "#remaining_uncleared_squares" do

    context "it should find and return coordinates of all uncleared('-' & '$') squares" do

      specify "for a full blank board" do
        coords = [[0, 0],[0, 1],[0, 2],[0, 3],[0, 4],[0, 5],[0, 6],[0, 7],[0, 8],[0, 9],
                  [1, 0],[1, 1],[1, 2],[1, 3],[1, 4],[1, 5],[1, 6],[1, 7],[1, 8],[1, 9],
                  [2, 0],[2, 1],[2, 2],[2, 3],[2, 4],[2, 5],[2, 6],[2, 7],[2, 8],[2, 9],
                  [3, 0],[3, 1],[3, 2],[3, 3],[3, 4],[3, 5],[3, 6],[3, 7],[3, 8],[3, 9],
                  [4, 0],[4, 1],[4, 2],[4, 3],[4, 4],[4, 5],[4, 6],[4, 7],[4, 8],[4, 9],
                  [5, 0],[5, 1],[5, 2],[5, 3],[5, 4],[5, 5],[5, 6],[5, 7],[5, 8],[5, 9],
                  [6, 0],[6, 1],[6, 2],[6, 3],[6, 4],[6, 5],[6, 6],[6, 7],[6, 8],[6, 9],
                  [7, 0],[7, 1],[7, 2],[7, 3],[7, 4],[7, 5],[7, 6],[7, 7],[7, 8],[7, 9],
                  [8, 0],[8, 1],[8, 2],[8, 3],[8, 4],[8, 5],[8, 6],[8, 7],[8, 8],[8, 9],
                  [9, 0],[9, 1],[9, 2],[9, 3],[9, 4],[9, 5],[9, 6],[9, 7],[9, 8],[9, 9]]
        expect(board.remaining_uncleared_squares).to eq(coords)
      end

      specify "for a partial board" do
        coords = [[0,1], [1,9], [2,2], [3,8], [5,5], [6,7], [7,3], [8,0], [8,5]]
        expect(win_board.remaining_uncleared_squares).to eq(coords)
      end

      specify "for a partial board with flags" do
        coords = [[0, 3],[0, 4],[0, 5],[0, 6],[0, 7],[0, 8],[0, 9],
                  [1, 3],[1, 4],[1, 5],[1, 6],[1, 7],[1, 8],[1, 9],
                  [2, 3],[2, 4],[2, 5],[2, 6],[2, 7],[2, 8],[2, 9],
                  [3, 3],[3, 4],[3, 5],[3, 6],[3, 7],[3, 8],[3, 9],
                  [4, 0],[4, 1],[4, 2],[4, 3],[4, 4],[4, 5],[4, 6],[4, 7],[4, 8],[4, 9],
                  [5, 0],[5, 1],[5, 2],[5, 3],[5, 4],[5, 5],[5, 6],[5, 7],[5, 8],[5, 9],
                  [6, 0],[6, 1],[6, 2],[6, 3],[6, 4],[6, 5],[6, 6],[6, 7],[6, 8],[6, 9],
                  [7, 0],[7, 1],[7, 2],[7, 3],[7, 4],[7, 5],[7, 6],[7, 7],[7, 8],[7, 9],
                  [8, 0],[8, 1],[8, 2],[8, 3],[8, 4],[8, 5],[8, 6],[8, 7],
                  [9, 0],[9, 1],[9, 2],[9, 3],[9, 4],[9, 5],[9, 6],[9, 7]]
        expect(partial_with_flags.remaining_uncleared_squares).to eq(coords)
      end

    end

  end


  describe "#clear_as_group" do

    context "the mines have been hidden and the square chosen by player is empty" do

      it "should return all groups that can be cleared by clicking one square" do
      end 

      it "" do
      end

    end


  end


  describe "#near_mines" do

    let(:mine_hash) { {1 => [3,3], 2 => [3,4], 3 => [3,5], 4 => [4,3], 5 => [5,3],
                       6 => [5,4], 7 => [5,5], 8 => [4,5], 9 => [8,5] } }

    let(:touching_one_mine) { [[2, 2], [2, 6], [6, 2], [6, 6], [7, 5], [7, 6],
                               [8, 6], [9, 6], [9, 5], [9, 4], [8, 4], [7, 4]] }

    let(:touching_two_mines) { [[2, 3], [3, 2], [2, 5], [3, 5], [3, 3], [3, 6],
                                [5, 3], [5, 2], [6, 3], [5, 5], [6, 5], [5, 6]] }

    let(:touching_four_mines) { [[3, 4], [4, 3], [4, 5], [5, 4]] }

    let(:touching_eight_mines) { [[4, 4]] }

  context "knowing where all mines are hidden" do

      it "should find and return all squares touching one mine" do
        mine = board.near_mines(mine_hash)
        expect(mine[1]).to eq(touching_one_mine)
      end

      it "should find and return all squares touching two mines" do
        mine = board.near_mines(mine_hash)
        expect(mine[2]).to eq(touching_two_mines)
      end

      it "should find and return all squares touching 5 mines" do
        mine = board.near_mines(mine_hash)
        expect(mine[4]).to eq(touching_four_mines)
      end

      it "should find and return all squares touching up to eight mines" do
        mine = board.near_mines(mine_hash)
        expect(mine[8]).to eq(touching_eight_mines)
      end

    end

  end






  describe "#win_game?" do

    let(:flag_win_board) { Board.new( [ [" ","$"," "," "," "," "," "," "," "," "],
                                        [" "," "," "," "," "," "," "," "," ","$"],
                                        [" "," ","$"," "," "," "," "," "," "," "],
                                        [" "," "," "," "," "," "," "," ","$"," "],
                                        [" "," "," "," "," "," "," "," "," "," "],
                                        [" "," "," "," "," ","$"," "," "," "," "],
                                        [" "," "," "," "," "," "," ","$"," "," "],
                                        [" "," "," ","$"," "," "," "," "," "," "],
                                        ["$"," "," "," "," ","$"," "," "," "," "],
                                        [" "," "," "," "," "," "," "," "," "," "]
                                      ] ) }

    it "should check for #remaining_uncleared_squares on board" do
      board = Board.new
      allow(board).to receive(:remaining_uncleared_squares).and_call_original
      expect(board).to receive(:remaining_uncleared_squares)
      board.win_game?(mine_hash)
    end

    context "if all squares without mines have been cleared" do

      it "should return true" do
        allow(win_board).to receive(:remaining_uncleared_squares).and_call_original
        expect(win_board.win_game?(mine_hash)).to be true
      end

    end

    context "if all mines have flags on them even if rest of squares haven't been cleared" do

      it "should return true" do
        expect(flag_win_board.win_game?(mine_hash)).to be true
      end

    end

  end

  describe "#lose_game?" do

    it "should return true if any mines have been uncovered" do
      coords = [8,0,1]
      board.click_square(coords, mine_hash)
      expect(board.lose_game?).to be true
    end

    it "should return false if no mines have been uncovered" do
      coords = [0,0,1]
      board.click_square(coords, mine_hash)
      expect(board.lose_game?).to be false
    end

  end

end

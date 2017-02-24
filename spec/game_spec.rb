require "game"

describe Game do
  let(:game){ Game.new }

  describe "#initialize" do
    it "has a 10x10 board by default" do
      # rows
      expect(game.board.length).to eq(10)
      # cols
      expect(game.board[0].length).to eq(10)
    end

    it "has 9 mines by default" do
      expect(game.mines).to eq(9)
    end

    it "has the same number of flags_remaining as mines" do
      expect(game.flags_remaining).to eq(game.mines)
    end
  end

  describe "#within_board_limits" do
    it "returns true if the given coordinates are within_board_limits" do
      expect(game.within_board_limits(0, 0)).to be(true)
      expect(game.within_board_limits(5, 5)).to be(true)
    end

    it "returns false if the given coordinates are not within_board_limits" do
      expect(game.within_board_limits(-1, -1)).to be(false)
      expect(game.within_board_limits(100, 100)).to be(false)
    end
  end

  describe "#generate_mines" do
    it "returns an array of axis with equivalent number of mines" do
      expect(game.generate_mines.length).to eq(game.mines)
    end

    it "has axis that are within the boundaries of the board" do
      rows, cols = game.board.length, game.board[0].length
      x, y = game.generate_mines[0]
      expect((0...rows).include?(x)).to be(true)
      expect((0...cols).include?(y)).to be(true)
    end
  end

  describe "#plant_mines!" do
    let(:mine){ {mine?: true} }

    it "plants mines on the positions given by #generate_mines" do
      positions = game.generate_mines
      game.plant_mines!(positions)
      x, y = positions.sample
      expect(game.board[x][y]).to eq(mine)
    end
  end

  describe "#render" do
    let(:string_input){ "hello world" }
    let(:array_input){ [string_input] }

    it "can handle a string as input" do
      expect{game.render(string_input)}.to output(/hello world/).to_stdout
    end

    it "can handle an array as input" do
      expect{game.render([string_input])}.to output(/hello world/).to_stdout
    end

    it "preppends a newline to the output" do
      expect{game.render(string_input)}.to output("\n#{string_input}\n").to_stdout
      expect{game.render([string_input])}.to output("\n#{string_input}\n").to_stdout
    end
  end

  describe "#clear_square!" do
    let(:is_mine){ {mine?: true} }
    let(:no_nearby_mines){ {count: 0} }
    let(:one_nearby_mine){ {count: 1} }
    let(:two_nearby_mines){ {count: 2} }
    let(:three_nearby_mines){ {count: 3} }

    it "can clear an empty square" do
      game.clear_square!(0, 0)
      expect(game.board[0][0]).to eq({count: 0})
    end

    it "ends the game if there's a bomb on the square" do
      game.app_state[:board][0][0] = is_mine
      expect(game.clear_square!(0, 0)).to be(false)
      expect(game.status.keys.first).to eq(:lose)
    end

    it "exposes that square nearby mine counts to one mine" do
      game.app_state[:board][0][1] = is_mine
      game.clear_square!(0, 0)
      expect(game.board[0][0]).to eq(one_nearby_mine)
    end

    it "exposes that square nearby mine counts to two mines" do
      game.app_state[:board][0][1] = is_mine
      game.app_state[:board][1][1] = is_mine
      game.clear_square!(0, 0)
      expect(game.board[0][0]).to eq(two_nearby_mines)
    end

    it "exposes that square nearby mine counts to three mines" do
      game.app_state[:board][0][0] = is_mine
      game.app_state[:board][0][1] = is_mine
      game.app_state[:board][0][2] = is_mine
      game.clear_square!(1, 1)
      expect(game.board[1][1]).to eq(three_nearby_mines)
    end

    it "exposes that square nearby mine counts up and down" do
      game.app_state[:board][6][0] = is_mine
      game.app_state[:board][8][0] = is_mine
      game.clear_square!(5, 5)
      game.clear_square!(7, 0)
      expect(game.board[7][0]).to eq(two_nearby_mines)
    end


    it "auto clears when there are no nearby bombs" do
      game.clear_square!(0, 0)
      expect(game.board[5][5]).to eq(no_nearby_mines)
    end
  end

  describe "#place_flag!" do
    let(:is_mine){ {mine?: true} }

    it "should place a flag on the referenced axis" do
      game.place_flag!(0, 0)
      expect(game.flagged?(0, 0)).to be(true)
    end

    it "should only be able to place flags on uncleared spaces" do
      game.clear_square!(0, 0)
      game.place_flag!(1, 1)
      game.app_state[:board][2][2] = is_mine
      game.app_state[:board][3][3] = nil
      expect(game.place_flag!(0, 0)).to be(false)
      expect(game.place_flag!(1, 1)).to be(false)
      expect(game.place_flag!(2, 2)).to be(true)
      expect(game.place_flag!(3, 3)).to be(true)
    end

    it "shouldn't place more flags if there are no more remaining" do
      game.app_state[:flags_remaining] = 0
      expect(game.place_flag!(0,0)).to be(false)
    end

    it "should update the remaining flag counter" do
      flags_before = game.flags_remaining
      game.place_flag!(0, 0)
      flags_after = game.flags_remaining
      expect(flags_after).to eq(flags_before - 1)
    end
  end

  describe "#play" do
    it "should display the instructions" do
      allow(game).to receive(:game_loop).and_return(nil)
      expect(game).to receive(:instructions)
      game.play
    end

    it "should place the generated mines on the board" do
      allow(game).to receive(:game_loop).and_return(nil)
      allow(game).to receive(:instructions).and_return(nil)
      mines = game.generate_mines
      allow(game).to receive(:plant_mines!).with(mines)
      expect(game).to receive(:plant_mines!)
      game.play
    end

    it "should begin the game loop" do
      allow(game).to receive(:instructions).and_return(nil)
      expect(game).to receive(:game_loop).and_return(nil)
      game.play
    end
  end

  describe "#player_input" do
    let(:valid_raw_input){ "c 1 1" }
    let(:sanitized_input){ [:C, 0, 0] }

    it "prompts the player for input" do
      expect(game).to receive(:gets).and_return(valid_raw_input)
      game.player_input
    end

    it "sanitizes and validates the user input, until a valid input comes" do
      invalid_action = "fuck, 1, 1"
      invalid_axis = "c, 100, 100"
      allow(game).to receive(:gets).and_return(invalid_action, valid_raw_input)
      result = game.player_input
      expect(result).to eq(sanitized_input)
    end
  end

  describe "#place_move!" do
    let(:flagged){ {flagged?: true} }
    let(:no_nearby_mines){ {count: 0} }

    it "makes the move according to the user input" do
      game.place_move!([:F, 0, 0])
      expect(game.board[0][0]).to eq(flagged)
      game.place_move!([:C, 1, 1])
      expect(game.board[1][1]).to eq(no_nearby_mines)
    end
  end

  describe "#board_full?" do
    it "returns true if there are no more nil cells" do
      game.clear_square!(5,5)
      expect(game.board_full?).to be(true)
    end
  end

end

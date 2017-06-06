require_relative '../lib/minesweeper'

describe MineSweeper do

  let(:new_game) { MineSweeper.new }

  context "when initialized" do

    it "should create a board" do
      expect(new_game.game_board).to be_a_kind_of(Board)
    end

    it "should create a new player" do
      player = Player.new
      new_game = MineSweeper.new(player)
      expect(player).to be_a_kind_of(Player)
    end

  end


  describe "#play_game" do

    it "should display instuctions by calling instructions method" do
      expect(new_game).to receive(:instructions)
      new_game.play_game
    end

    it "should have board #hide_mines" do
      allow(new_game.game_board).to receive(:hide_mines).and_call_original
      expect(new_game.game_board).to receive(:hide_mines)
      new_game.play_game
    end

    context "manages game loop" do

      it "should start by having board render current game board" do
        expect(new_game.game_board).to receive(:render_board)
        new_game.play_game
      end

      it "should ask the player for movement" do
        player = double("Player")
        new_game = MineSweeper.new(player)
        expect(player).to receive(:click_selection)
        new_game.play_game
      end

      it "should ask board to click square" do
        allow(new_game.game_board).to receive(:click_square).and_call_original
        expect(new_game.game_board).to receive(:click_square)
        new_game.play_game
      end

      it "should check with board for winning condition" do
        expect(new_game).to receive(:win?)
        new_game.play_game
      end

      it "should check with board for losing condition" do
        expect(new_game).to receive(:lose?)
        new_game.play_game
      end

    end

  end

  describe "#win?" do

    it "should check with board for a winning condition" do
      mines = {1 => [0,1], 2 => [1,9], 3 => [2,2], 4 => [3,8], 5 => [5,5],
               6 => [6,7], 7 => [7,3], 8 => [8,0], 9 => [8,5]}
      expect(new_game.game_board).to receive(:win_game?)
      new_game.win?(mines)
    end

  end

  describe "#lose?" do

    it "should check with the board for a losing condition" do
      expect(new_game.game_board).to receive(:lose_game?)
      new_game.lose?
    end

  end



end # end of describe MineSweeper

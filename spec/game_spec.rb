require "game"

describe Game do
  let(:game){ Game.new }

  describe "board" do
    it "has a 10x10 board by default" do
      # rows
      expect(game.board.length).to eq(10)
      # cols
      expect(game.board[0].length).to eq(10)
    end

    it "has 9 mines by default" do
      expect(game.mines).to eq(9)
    end
  end

  describe "#plant_mines" do
    it "returns an array of axis with equivalent number of mines" do
      expect(game.plant_mines.length).to eq(game.mines)
    end

    it "has axis that are within the boundaries of the board" do
      rows, cols = game.board.length, game.board[0].length
      x, y = game.plant_mines[0]
      expect((0...rows).include?(x)).to be(true)
      expect((0...cols).include?(y)).to be(true)
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


end

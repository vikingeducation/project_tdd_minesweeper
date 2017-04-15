require 'game'

describe Game do
  let(:game) { Game.new }
  describe ' #initialize ' do
    it ' creates a new Minesweeper game board of type Minesweeper ' do
      expect(game.board).to be_a(Minesweeper)
    end
  end

  describe ' #play ' do
    it ' starts the game loop ' do
      expect(game).to receive(:play)
      game.play
    end

    it ' calls render on the board ' do
      expect(game.board).to receive(:render).at_least(:once) 
      game.play
    end

    it ' calls a turn on the board ' do
      expect(game.board).to receive(:turn)
      game.play
    end
  end
end


require_relative '../lib/player.rb'
require_relative '../lib/board.rb'
require_relative '../lib/tile.rb'


describe Player do


  let (:p) {Player.new(Board.new)}

  describe "#initialize" do

    it "is a player" do

      expect(p).to be_a(Player)

    end

  end

  describe "#get_move" do

    it "returns a Tile" do

      allow(p).to receive(:get_move_type).and_return("c")
      allow(p).to receive(:get_coordinates).and_return([1,1])
      expect(p.get_move).to be_a(Tile)

    end

    it "calls get_move_type" do

      expect(p).to receive(:get_move_type)
      allow(p).to receive(:get_coordinates)
      allow(p).to receive(:perform_move).with(any_args)
      p.get_move

    end

    it "calls #get_coordinates method" do

      expect(p).to receive(:get_coordinates)
      allow(p).to receive(:get_move_type)
      allow(p).to receive(:perform_move).with(any_args)
      p.get_move

    end

  end

  describe "#perform_move" do

    let(:my_tile) {Tile.new(4,5)}
    let(:my_board) { double("a_board")}

    it "clears a tile if not already cleared" do

      p.instance_variable_set(:@board, my_board)

      allow(my_board).to receive(:game_state).and_return([[my_tile]])
      allow(my_board).to receive(:clear_nearby)
      p.perform_move("c",[0,0])
      expect(my_tile.is_cleared).to be true

    end

    it "doesn't clear a tile if already cleared" do

      p.perform_move("c",[0,0])

      expect{p.perform_move("c",[0,0])}.to output("You already cleared this tile\n").to_stdout

    end

    it "doesn't clear a tile if there's a flag" do

      p.perform_move("f",[0,0])

      expect{p.perform_move("c",[0,0])}.to output("You must remove the flag before clearing a tile\n").to_stdout

    end

    it "places flag if tile is uncleared" do

      flagged_tile = p.perform_move("f",[0,0])

      expect(flagged_tile.is_flag).to be true

    end

    it "doesn't place a flag if tile is cleared" do

      p.perform_move("c",[0,0])
      expect{p.perform_move("f",[0,0])}.to output("No need to place a flag here ;)\n").to_stdout

    end

    it 'takes down flag if there is already one' do

      flagged_tile = p.perform_move("f",[0,0])
      flagged_tile = p.perform_move("f",[0,0])

      expect(flagged_tile.is_flag).to be false
      
    end

    it "doesn't place a flag if there are no flags remaining"


  end

  describe "#get_move_type" do

    it "loops until it gets an f" do

      allow(p).to receive(:gets).and_return("a","b","f")
      expect(p).to receive(:print).exactly(3).times
      p.get_move_type

    end

    it "loops until it gets a c" do 

      allow(p).to receive(:gets).and_return("a","b","d", "c")
      expect(p).to receive(:print).exactly(4).times
      p.get_move_type


    end

    it "returns the letter the user inputs" do 

      allow(p).to receive(:gets).and_return('c')
      allow(p).to receive(:print)
      expect(p.get_move_type).to eq('c')

    end

  end

  describe "#get_coordinates" do

    it "keeps asking for input if it's a string" do

      allow(p).to receive(:gets).and_return('car', "hello", "ASDDFWE", "1,2")
      expect(p).to receive(:print).exactly(4).times
      p.get_coordinates

    end

    it "keeps asking for input if it's a float" do

      allow(p).to receive(:gets).and_return('1.0', "11.2, 3.1", "1.2, 2.3, 3.6, 4.4", "1,1")
      expect(p).to receive(:print).exactly(4).times
      p.get_coordinates

    end
    it "keeps asking for input if it's an integers without comma" do

      allow(p).to receive(:gets).and_return("1", "2", "1,2")
      expect(p).to receive(:print).exactly(3).times
      p.get_coordinates

    end

    it "returns an array with two integers" do

      allow(p).to receive(:gets).and_return("1,1")
      allow(p).to receive(:print)
      expect(p.get_coordinates).to eq([1,1])

    end

  end
end
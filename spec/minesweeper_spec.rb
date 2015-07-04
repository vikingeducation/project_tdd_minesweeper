require_relative '../lib/minesweeper.rb'

describe Minesweeper do




end


describe Board do

let (:b) {Board.new}

  describe '#initialize' do



  end

  describe '#create_board' do

    it 'returns an 10 x 10 array with dashes inside' do

      example_board = [%w(- - - - - - - - - -),
                      %w(- - - - - - - - - -),
                      %w(- - - - - - - - - -),
                      %w(- - - - - - - - - -),
                      %w(- - - - - - - - - -),
                      %w(- - - - - - - - - -),
                      %w(- - - - - - - - - -),
                      %w(- - - - - - - - - -),
                      %w(- - - - - - - - - -),
                      %w(- - - - - - - - - -),]

      returned_array = b.create_board

      expect(returned_array).to eq(example_board)

    end

  end

  describe "#generate_bombs" do

    it "returns an array" do

      expect(b.generate_bombs).to be_an(Array)

    end

    it "returns an array of the coordinates for 9 bombs" do

      bombs = b.generate_bombs

      expect(bombs.length).to eq(9)

      coords = bombs.all? {|bomb| bomb.length == 2}

      expect(coords).to be true

    end

    it "doesn't generate the same bomb twice" do

      bombs = b.generate_bombs

      checked_bombs = bombs.uniq

      expect(bombs).to eq(checked_bombs)


    end

  end




end
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




end
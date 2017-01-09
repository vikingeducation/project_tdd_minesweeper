# RSPEC test of blackjack suite

# class Game


require 'board.rb'
include Minesweeper

# note: no initialize method ... so added one

describe Board do
  let (:layout_no_arguments){Board.new}

  describe '#initialize' do
    it 'should give you a Board' do
      expect(layout_no_arguments).to be_a(Board)
    end

    
  end

  

end


# Question: how test method play which only calls other methods in?
#presumably stub them, ie, input dummy return values


  




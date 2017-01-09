# RSPEC test of blackjack suite

# class Game


require 'game.rb'
include Blackjack

# note: no initialize method ... so added one

describe 'Game' do
  let (:gme){Game.new}

  describe '#initialize' do
    it 'should give you a Game' do
      expect(gme).to be_a(Game)
    end
  end

end


# Question: how test method play which only calls other methods in?
#presumably stub them, ie, input dummy return values


  




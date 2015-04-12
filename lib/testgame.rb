require './minefield.rb'

test = Minefield.new(9, 9)
test.place_mines(10)
test.place_mine_indicators
test.render
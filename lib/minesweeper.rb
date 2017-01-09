# Minesweeper

# program collector

require './game'
require './board'
require './cell'
require './player'

# Includes the Minesweeper
# module into the global
# namespace
include Minesweeper

puts "\nReady to play ... please wait"
sleep(1)

Game.new.play



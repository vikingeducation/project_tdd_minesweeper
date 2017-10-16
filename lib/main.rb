 require_relative 'game'

Game.new.play


=begin Pseudocode


render_welcome
render_instructions
request board_size
generate empty grid based on board_size
randomly place board_size number of mines in grid
assign clues to grid
render masked grid to user
while game_over? == false
  request user guess
  validate response
  check response against mine locations
  check for game_over?
    game_won? || game_lost?
    (render game over message)
    game_over == true
  reveal appropriate cells
exit_game



=end


# project_tdd_minesweeper
Code go boom!

[A Ruby Test-Driven Development (TDD) project using RSpec from the Viking Code School](http://www.vikingcodeschool.com)

Kit Langton and Josh Masland

# Planning

Board
  randomly place mines
  default mines = 9
  to_s
    render a properly
  check_neighbors
    loop through neighbors_from_a_coordinate
    store unsafe neighbors in tile
    call reveal_square on safe neighbors only if that square is already revealed
  reveal_square
    mark as cleared
    check_neighbors
  place_flag
    only if there are flags remaining
    mark as flagged
    decrement flags remaining
  number of flagged squares
  remaining flags
  mine_detonated?
  non-mine squares revealed

Tile
  to_s
    cleared and mine - mine
    flagged - flag
    etc...
  mine true/false
  cleared true/false
  flagged true/false
  unsafe_neighbors

Game
  board
  play
    render
    user_input (coords)
      send to board
    update
  loop until game over


Tests for overall game
  Set up the game [Game]
    Create a board [Board]
  play
    Setup
    Game Loop
  Setup
    render (once) [Board]
  Game Loop [Game]
    Get and test input [Game]
    Make the move [Board]
    Check game over [Game]
      if game over
        break from loop
    Render [Game]
  Game Over [Game]
    Render last board with special message: [Game]
      Loss?
        loss message
      Win?
        win message
      render all mines
  Win? [Game]
    all squares without mines revealed
  Loss? [Game]
    player has revealed a mine

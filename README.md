# project_tdd_minesweeper
Code go boom!

[A Ruby Test-Driven Development (TDD) project using RSpec from the Viking Code School](http://www.vikingcodeschool.com)

Kit & Deepa

# Planning

Default Mines (mines: 9)
Default Grid (10 x 10)

get user action (flag or reveal)
get user coordinate

safe, dangerous: 1-8, mine

## Renderer
  loop
    case key
    when key :enter
      game.reveal_coord(current_coord)
    break if game_over?

## Game
  game_over?
    board.any_mines_revealed? ||
    board.all_safe_tiles_revealed?

  reveal_coord(coord)
    board.reveal_coord(coord)

  flag_coord(coord)
     board.flag_coord(coord)

## Board
  @data = [ [tile, tile, tile], [tile, tile, tile] ]
  Tile.new(board: self)

  build_board(mines, size)

  any_mines_revealed?
    mines = @data.flatten.select { |tile| tile.mine? }
    mines.any? { |mine| mine.revealed? }

  all_safe_tiles_revealed?
    unmined_tiles = @data.flatten.select { |tile| tile.unmined? }
    unmined_tiles.all? { |mine| mine.revealed? }

  reveal_coord(coord)
   tile = self.tile_at(coord)
   return false if tile.flagged?
   tile.reveal

  flag_coord(coord)
   tile = self.tile_at(coord)
   return false if tile.revealed?
   tile.flag

  coords_for_tile(tile)

  neighbors_for(tile)

  completely_safe?(tile)
    danger_level_for_tile == 0

  danger_level_for_tile(tile)
    neighbors_for(tile).count { |tile| tile.mine? }


## Tile
  @board = board
  @revealed = false
  @mine = false
  @flagged = false

  mine?
    @mine

  revealed?
    @revealed

  unmined?
    !@mine

  flag
    @flagged = !@flagged

! _     O 1234 *

  display_tile
    if revealed?
      if mined?
        "*"
      else
        danger_level.to_s
    else
      if flagged?
        "!"
      else
        "_"
      end
    end

  danger_level
    board.danger_level_for_tile(self)

  reveal
    @revealed = true
    if completely_safe?
      board.reveal_all_neigbors
    if mined?
      board.reveal_all_mines

  completely_safe?
    return false mine?
    board.completely_safe?(self)

REVEAL:

  if the coordinate is COMPLETELY safe:
    recursively clear squares until it reaches a dangerous square (clears the dangerous square)

  if the coordinate is DANGEROUS:
    reveal only that dangerous square (with danger level, number of adjacent mines)

  if the coordinate is MINE:
    game over. Reveal all mine squares


FLAG:
  flags the square

GAMELOOP: case key
  when :space
    game.flag_at_coord(current_coord)
  when :enter
    game.reveal_at_coord(current_coord)
  when :

  game.display

  print
board.display

O O O O O O O
1 O O 1 1 O O

map

#game_over?:
  all mines are flagged?
  any mine is revealed?

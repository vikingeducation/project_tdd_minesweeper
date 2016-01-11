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
    when key :space
      game.flag_coord(current_coord)
    break if game_over?
    display

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

  build_board(mines, size, starting_coord)
    @data = Array.new(size) { Array.new(size) { Tile.new } }
    mines.times do
      don't set a mine if there's already a mine
      don't set a mine if it's a starting_coord
      random_tile.set_mine
    end

  set_danger_levels
    @data.each do |row|
      row.each do |tile|

      end
    end

  coord_for_tile

  tile_for_coord

  adjacent_mines_for(coord)

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
   if tile.completely_safe?
     reveal_neigbors(tile)
   elsif tile.mine?
     reveal_all_mines

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
  @adjacent_mines = 4

  mine?
    @mine

  revealed?
    @revealed

  unmined?
    !@mine

  adjacent_mines
    @adjacent_mines

  flag
    @flagged = !@flagged

  to_s
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

  reveal
    @revealed = true

REVEAL:

  #----dkackar---------------------------------#
  # tile = unrevealed do below 
  #--------------------------------------------#
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


#------dkackar---

User clicks space
  
  Board:
    get tile at the coordinate
    if Tile: tile is not flagged or revealed (from tile class)
       flag_at_coordinate (tile.flag)
    end

User clicks enter
    Board:
      get tile at the coordinate
      
      if  Tile: tile is not flagged or revealed
          BOARD: PROC REVEAL ---(1)
           tile.reveal == true
          
           if tile.mined
             Board : reveal all mines 
          
           elseif tile.danger_level is NO Danger (i.e. no mines)
             Board: get_all_neighbors_for_tile
             for each neighbor call (1)
          
           elseif tile.danger ? (with 1 or more mines next it)
             return
      end       

            
        
def tile_coord(tile)
  board.each_index { |row| col = a[row].index(tile); p [row, col] if col }
end  

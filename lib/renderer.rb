require_relative 'board'
require_relative 'tile'
require 'dispel'

class Renderer
  def self.start
    ::Dispel::Screen.open(colors: true) do |screen|

      game = Board.new
      started = false
      content = game.to_s

      x = game.size
      y = game.size / 2

      screen.draw content, [], [y,x]

      Dispel::Keyboard.output timeout: 0.5 do |key|
        case key
        when :right
          next if x+2 > game.size * 2 -2
          x += 2
        when :left
          next if x-2 < 0
          x -= 2
        when :down
          next if y+1 > game.size - 1
          y += 1
        when :up
          next if y-1 < 0
          y-= 1
        when " "
          coord = [y,x/2]
          game.populate_mines(coord) unless started
          game.reveal_coord(coord)
        when "f"
          coord = [y,x/2]
          game.populate_mines(coord) unless started
          game.flag_coord(coord)
        when "q" then break
        when "r" then return self.start

        end

        content = game.to_s
        screen.draw content, [], [y,x]
      end
    end
  end
end

Renderer.start

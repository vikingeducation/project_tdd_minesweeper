require 'colorize'
class Square
  attr_reader :mine, :state, :neighboring_mines
  attr_accessor :coordinates
  def initialize
    @coordinates = []
    @state = :none
    @mine = false
    @neighboring_mines = nil
    @auto_cleared = false
  end

  def make_mine
    @mine = true
  end

  def remove_mine
    @mine = false
  end

  def clear
    !mine? ? @state = :cleared : nil
  end

  def auto_clear
    @auto_cleared = true
  end

  def flag
    !cleared? && !flaged? ? @state = :flaged : nil
  end

  def unflag
    flaged? ? @state = :none : nil
  end

  def mine?
    @mine
  end

  def update_mine_count(count)
    @neighboring_mines = count
  end

  def flaged?
    state == :flaged
  end

  def cleared?
    state == :cleared
  end

  def auto_cleared?
    @auto_cleared
  end

  def neighboring_mines_zeros?
    @neighboring_mines == 0
  end

  def to_s(show_mines = false)
    if flaged?
      print "F".red
    elsif cleared?
      case @neighboring_mines
        when 0 then print " "
        when 1 then print "1".blue
        when 2 then print "2".green
        when 3 then print "3".red
        when 4 then print "4".yellow
        when 5 then print "5".magenta
        when 6 then print "6".light_magenta
        when 7 then print "7".cyan
        when 8 then print "8".light_cyan
        else
          print " "
      end
    elsif mine?
      show_mines ? print("x".black) : print("-")
    else
      print "-"
    end
  end
end
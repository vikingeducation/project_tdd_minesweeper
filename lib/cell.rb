module Minesweeper
  class Cell
    attr_reader :state,
                :mine,
                :adjacent_mine_count

    def initialize
      @state = :uncleared
      @mine = false
      @adjacent_mine_count = 0
    end

    # clears a Cell
    def clear
      @state = :cleared
    end

    # flags a Cell
    def flag
      @state = :flagged unless @state == :cleared
    end

    # unflags a Cell
    def unflag
      @state = :uncleared unless @state == :cleared
    end

    # sets whether the Cell is a mine
    def mine=(value)
      raise "A cell's mine must be true or false." unless [true, false].include?(value)

      @mine = value
    end

    # sets the Cell's adjacent mine count
    def adjacent_mine_count=(value)
      raise "A cell's adjacent_mine_count can only be set to a value from 0 to 8" unless (0..8).include?(value)

      @adjacent_mine_count = value
    end

    def to_s
      case state
      when :uncleared
        '.'
      when :flagged
        'F'
      when :cleared
        self.mine ? 'X' : adjacent_mine_count.to_s
      end
    end
  end
end
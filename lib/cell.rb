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

    def state=(state)
      raise "You are trying to set an invalid state." unless [:cleared, :uncleared, :flagged].include?(state)

      @state = state
    end

    def mine=(value)
      raise "A cell's mine must be true or false." unless [true, false].include?(value)

      @mine = value
    end

    def adjacent_mine_count=(value)
      raise "A cell's adjacent_mine_count can only be set to a value from 1 to 8" unless (1..8).include?(value)

      @adjacent_mine_count = value
    end
  end
end
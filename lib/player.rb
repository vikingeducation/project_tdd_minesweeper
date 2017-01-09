# Minesweeper

# class Player

module Minesweeper
  class Player


# ######################



    attr_reader :name, :chips, :bet, :blackjack, :bust
    attr_reader :bust_with_ace 
    attr_accessor :hand, :points, :result 

    def initialize(deck, board, name, chips)
      @deck = deck
      @board = board
      @name = name
      @chips = chips
      @hand = []
      @points = 0
    end

    private

    def place_bet
      print %{
#{name}, you have #{@chips} chips left. What is your bet for this round? 
Enter chips in multiples of 20 (maximum of 100). Do not exceed your 
available chips! }
      until [20, 40, 60, 80, 100].include? (@bet = gets.chomp.to_i) \
        and @bet <= @chips
        print "Incorrect amount - try again: "
      end
      @chips -= @bet
      puts "You have #{@chips} chips left." #test
    end

    def players_continue
      puts "\n#{@name}'s turn ..."
      loop do 
        @blackjack, @bust, @bust_with_ace = false, false, false
        blackjack? || bust_with_ace? || bust?
        @board.render_layout 
        if @blackjack || @bust || next_move == "P" 
          print "\nEnd of #{@name}'s turn; press enter to continue." 
          gets
          return
        end
        deal_card
      end
    end

    def win
      @chips += @bet * 2 # return bet plus winnings
      @result = :win
    end

    def win_blackjack
      @chips += (@bet * 2.5).to_i # return bet plus winnings
      @result = :win_blackjack
    end

    def lose
      # @chips remain the same because @bet has already been deducted when bet placed
      @result = :lose
      @result = :game_lost if @chips == 0
      @result = :insufficient_chips if @chips < 20
    end

    def stand_off
      @chips += @bet # return bet
      @result = :stand_off
    end

    public :place_bet, :players_continue, :win, :lose
    public :win_blackjack, :stand_off

    private

    def bust_with_ace?
      if @points > 21
        @hand.each do |card|
          if card[:value] == 11
            card[:value] = 1
            @points -= 10
            @bust_with_ace = true
            return true # return immediately so that another ace in hand is not reset as well
          end
        end
      end
      false
    end

    def next_move
      print "\n#{@name}: do you want to hit or pass (H or P)? "
      until %w(H P).include? (answer = gets.chomp)
        print "Incorrect answer -- try again: "
      end
      answer
    end

  end # class Player
end # module Blackjack 


# Minesweeper

# class Game


module Minesweeper
  class Game

    def initialize
    end

    def play
      setup
      play
      render
      finish
    end

    def set_up
      welcome
      setup_board
      setup_cells
      
    end

    def setup_board
#      size = input_layout_size
#      mines = input_mines
      board = Board.new(size, mines)
    end

    def input_layout_size
      puts "How many squares on each side of the square (10 - 25)?"
      until (10..25).include? (answer = gets)
        print "Incorrect answer - try again."
      end
      return size
    end

    def input_mines
      puts "How many mines (5 - 50)?"
      until (5..50).include? (answer = gets)
        print "Incorrect answer - try again."
      end
      return mines
    end




      loop do
        until %w(Y N).include? (answer = gets.chomp)
          print "Incorrect answer - try again. "
        end
        return if answer == "N"
      end



  end
end

# #########################################


    def play
      set_up
      loop do           # rounds have two parts with different rules:
        begin_round     # where each player is dealt two cards  
        continue_round  # where each player in turns decides to hit, pass, etc. and dealer comes last
        results         # analyze who wins, loses, draws
        another_round   # exit unless choosing another round
      end
    end

    private

    def set_up
      welcome
      setup_deck
      setup_board
      setup_participants
    end

    def welcome

      puts %{ 

WELCOME TO BLACKJACK!

Rules: One or more players play against a dealer. Players attempt to 
beat the dealer's hand without going over 21. All are dealt 2 cards 
(only one of the dealer's cards is shown to start) and may continue 
to "hit" (ask for another card) until they choose to "pass" (stop 
hitting) or "bust" (go over 21). 

In the following, "he/his" is short for "he/she/his/her." 

Some additional rules:

1. Players bet before each round. When a player wins, he is paid 
   equal to his bet.
2. Numbered cards have value equal to their number. Face cards(
   Queen, King, Jack) are all worth 10. Aces count as either 1 or 
   11, whichever is more advantageous.
3. If a player is dealt 21 points from the first two cards, it is a 
   "blackjack" and the payout is 1.5x the bet (versus the normal 1x 
   the bet). This is paid immediately unless the dealer also has a 
   "blackjack", in which case everyone loses immediately.
4. The dealer must hit until his total reaches at least 17, then 
   must pass. If the dealer has at least 17 which in-cludes an ace 
   that could put his points value below 17 (by equaling 1 instead 
   of 11), the ace value is set to 1 and the dealer continues to hit.
      }
 
#     sophisticated_option?
#       TODO (optional method for future programming)

      puts "Now please enter player details:"

    end

# begin optional method for future programming

    def sophisticated_option? # TODO optionally 
      puts %{
Sophisticated blackjack has options to "split pairs" and "double 
down." Do you want information on these (Y or N)? }

      loop do
        until %w(Y N).include? (answer = gets.chomp)
          print "Incorrect answer - try again. "
        end
        return if answer == "N"
      end

      puts %{

Splitting Pairs
---------------
A player who starts out with two of any card (e.g. two 8's) may 
"split". Each card is split from the other into a new hand, an equal 
bet is added to the new hand, and a new card is dealt to each hand. 
Each hand is then played as normal from there, though no 
"blackjacks" occur.

Doubling Down
-------------
A player may choose to "double down" as the first move on any new 
hand. This means the player doubles his/her bet, and will receive 
a single dealt card (with no option to continue hitting). The dealer 
draws as normal afterwards.

      }

    end
     

    def setup_deck
      @deck = Deck.new
    end

    def setup_board
      @board = Board.new
    end

    def setup_participants  
      @initial_players = []
      @dealer = Dealer.new(@deck, @board, "Dealer")
      enter_players
      @board.board_copy(@dealer, @initial_players)
    end

    def enter_players
      loop do
        @initial_players << Player.new(@deck, @board, get_player_name, get_player_chips)
        print "\nAnother player (Y or N)? "
        until %w(Y N).include? (answer = gets.chomp)
          print "Incorrect answer - try again: "
        end
        break if answer == "N"
      end
    end

    def get_player_name
      print "\nWhat is your name? "
      while "" == (name = gets.chomp)
        print "\nYou did not enter an answer. Try again: "
      end
      name
    end

    def get_player_chips
      puts "How many chips are you bringing to the table?" 
      print "Enter 100, 200, 300, 400, or 500: "
      until [100, 200, 300, 400, 500].include?(amount = gets.chomp.to_i)
        print "\nIncorrect amount - try again: "
      end
      amount
    end

    def begin_round
      initialize_variables
      place_bets
      @dealer.deal_card
      @board.players.each {|player| 2.times{player.deal_card}}
        # deal 2 cards to each player
      @board.dealer_render_layout_note # dealer displays just one card
    end

    def initialize_variables  
      @deck.create_card_deck
      @dealer.points = 0   
      @dealer.hand = []
      @dealer.blackjack, @dealer.ace_with_over_16, @dealer.bust = false, false, false # needed here to stop these values being carried over to and displayed in a next round (they can't be changed to false until his turn in the round which comes AFTER all the players. Whereas each player's similar variables are made false BEFORE their turns in the round -- see code in class Player/Dealer method dealer_continues and players_continue.)
      @board.players.each do |player| 
        player.points = 0
        player.hand = []
        player.result = :not_set
      end
    end

    def place_bets
      @board.players.each {|player| player.place_bet} 
      @board.render_bets # after all bets placed
    end

    def continue_round
      @board.players.each {|player| player.players_continue}
      @dealer.dealer_continues
    end

    def results
      @board.players.each do |player|
        @player = player
        puts
        dealer_blackjack? || player_blackjack? || player_bust? || dealer_bust? || evaluate_on_points
      end
      @board.render_results
      remove_game_losers
    end

    def dealer_blackjack?
      if @dealer.blackjack
        @player.lose 
        true
      end
    end

    def player_blackjack?
      if @player.blackjack
        @player.win_blackjack 
        true
      end      
    end

    def player_bust?
      if @player.bust
        @player.lose
        true
      end
    end

    def dealer_bust?
      if @dealer.bust
        @player.win
        true
      end
    end

    def evaluate_on_points
      if @dealer.points > @player.points
        @player.lose
      elsif @dealer.points < @player.points
        @player.win
      else
        @player.stand_off
      end
    end

    def remove_game_losers
      @board.players.delete_if {|player| player.result == :game_lost || player.result == :insufficient_chips}
    end

    def another_round
      if @board.players.empty?
        puts "No more players left."
      else
        print "\nAnother round (Y or N)? "
        until %w(Y N).include? (answer = gets.chomp)
          print "incorrect answer - try again"
        end
        return if answer == "Y"
      end
      puts "\nThank you for playing!\n\n"
      exit
    end

  end # class Game
end # module Blackjack 

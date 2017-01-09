# Minesweeper

# class Board

module Minesweeper
  class Board

# ############################



    attr_reader :players

    private

    def board_copy(dealer, players)
      @dealer = dealer # not array
      @players = players # array
    end

    def render_bets
      puts "\nBets Placed"
      puts "-" * 11
      @players.each do |player|
        puts "#{player.name.ljust(12, padstr = " ")}: #{player.bet.to_s.rjust(3, padstr = " ")} chips. Available chips = #{player.chips.to_s.rjust(3, padstr = " ")}."
      end
    end

    def dealer_render_layout_note
      if @dealer.hand.length == 1
        puts %{
Note: dealer's points are for only his FIRST card until his turn at 
end of round. } # note: program deals out dealer's second card then
      end
    end

    def render_results
      puts "Results"
      puts "-" * 7
      player_results
      puts "\nAny players whose names are missing have lost the game."
    end

    def render_layout
      puts "\nLatest Results"
      puts "-" * 14
      print @dealer.name.ljust(12, padstr = " "), ": ", @dealer.points.to_s.rjust(2, padstr =" "), " "
      render_layout_notes(@dealer)
      @players.each do |player|
        print player.name.ljust(12, padstr = " "), ": ", player.points.to_s.rjust(2, padstr =" "), " "
        render_layout_notes(player)
      end
    end

    private

    def render_layout_notes(person)
      @person = person
      if @person.blackjack
        puts "Blackjack!"
      elsif @person.bust
        puts "Bust!" 
      else
        render_layout_aces
        puts # new line if no notes
      end
    end

    def render_layout_aces      
      @person.hand.each do |card|
        if card[:value] == 11 || card[:value] == 1
          print "Includes ace at #{card[:value]} point(s). "
        end
      end
      print "As score had been over 21, one ace was reset to 1 point. "   if @person.bust_with_ace == true 
      print "As score had been 17 or over, one ace was reset to 1 point. " if @person.ace_with_over_16 == true
    end

    def player_results
      @players.each do |player|
        case player.result
        when :win
          puts "#{player.name.ljust(12, padstr = " ")}: wins  #{player.bet.to_s.rjust(3, padstr = " ")} chips. Available chips = #{player.chips.to_s.rjust(3, padstr = " ")}."
        when :win_blackjack
          puts "#{player.name.ljust(12, padstr = " ")}: wins  #{(player.bet * 1.5).to_i.to_s.rjust(3, padstr = " ")} chips. Available chips = #{player.chips.to_s.rjust(3, padstr = " ")}."
        when :lose
          puts "#{player.name.ljust(12, padstr = " ")}: loses #{player.bet.to_s.rjust(3, padstr = " ")} chips. Available chips = #{player.chips.to_s.rjust(3, padstr = " ")}."
        when :game_lost
          puts "#{player.name.ljust(12, padstr = " ")}: loses #{player.bet.to_s.rjust(3, padstr = " ")} chips. No chips left. Game lost. Better luck next time!"
        when :insufficient_chips
          puts "#{player.name.ljust(12, padstr = " ")}: loses #{player.bet.to_s.rjust(3, padstr = " ")} chips. Not enough chips left to continue. Better luck next time!"
        when :stand_off
          puts "#{player.name.ljust(12, padstr = " ")}: has a stand-off (draw) and gets back bet of #{player.bet} chips. Available chips = #{player.chips.to_s.rjust(3, padstr = " ")}."
        end
      end
    end      

    public :board_copy, :dealer_render_layout_note, :render_bets 
    public :render_layout, :render_results

  end # class Board
end # module Blackjack 
   
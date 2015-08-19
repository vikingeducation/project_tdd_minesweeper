require_relative 'interface'

class Minesweeper
    attr_accessor :game
    
    def initial(size = [10, 10])
       @game = Interface.new(size)
    end
    
    def play
       puts "welcome to the game"
       puts "which size do you want input an array or use default 10*10 size"
       arr = []
       while arr.length !=2 do
           puts "please enter the width"
           w = gets.chomp.to_i
           puts "please enter the length"
           l = gets.chomp.to_i
           arr = [w, l]
       end
       initial(arr) if arr != [nil, nil]
       sweep(@game)
    end
    
    def sweep(interface)
       choice = 0
       position = []
       interface.display(interface.board)
       puts "you game begin ..."
       loop do
          choice = choose_mode(choice)
          case(choice)
          when (1)
          position = getposition
          @game.flag(position)
          when (2)
          position = getposition
          @game.deflag(position)
          when (3)       
          position = getposition
          @game.click(position)
          end
          signal = @game.compare(@game.board, @game.solution.board)
          break if signal == "you win"
        end
    end
    
    def choose_mode(num)
       puts "which model do you want?"
       puts "1 for flag; 2 for deflag, 3 for click"
       choice = gets.chomp.to_i
       while ![1, 2, 3].include?(choice) do
          puts "enter again"
          choice = gets.chomp.to_i
       end
       puts "the choise you made is #{choice}"
       return choice
    end
    
    def getposition
       pos = [0, 0]
       puts "enter width(only number)"
       while (pos[0] <= 0 || pos[0] > @game.width || (pos[0].class != Fixnum)) do
           puts "enter a number"
           pos[0] = gets.chomp.to_i
       end
       puts "enter length(only number)"
       while (pos[1] <= 0 || pos[1] > @game.length || (pos[1].class != Fixnum)) do
           puts "enter a number"
           pos[1] = gets.chomp.to_i
       end
       pos 
    end
    
end

m = Minesweeper.new
m.play
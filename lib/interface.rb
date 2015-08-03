require_relative 'solution'

class Interface
   attr_accessor :board, :testbench, :width, :length, :solution
   
   def initialize(matrix=[10,10])
      @board = init(matrix)
      @width = matrix[0]
      @length = matrix[1]
      @solution = Solution.new([@width, @length])
      @testbench = {}
   end
   
   def testset
       
   end
   
   def init(matrix)
       board = {}
       1.upto(matrix[0]) do |w|
           1.upto(matrix[1]) do |l|
               board[[w,l]] = " # "
           end
       end
       @board = board
   end
   
   def godset
       @solution.board = {
           [1, 1]=>" O ", [1, 2]=>" O ", [1, 3]=>" O ", [1, 4]=>" O ",
           [1, 5]=>" O ", [1, 6]=>" 1 ", [1, 7]=>" X ", [1, 8]=>" 1 ",
           [1, 9]=>" O ", [1, 10]=>" O ", [2, 1]=>" O ", [2, 2]=>" O ",
           [2, 3]=>" O ", [2, 4]=>" O ", [2, 5]=>" O ", [2, 6]=>" 1 ",
           [2, 7]=>" 1 ", [2, 8]=>" 1 ", [2, 9]=>" O ", [2, 10]=>" O ",
           [3, 1]=>" 1 ", [3, 2]=>" 1 ", [3, 3]=>" 1 ", [3, 4]=>" 1 ",
           [3, 5]=>" 1 ", [3, 6]=>" O ", [3, 7]=>" O ", [3, 8]=>" 1 ",
           [3, 9]=>" 1 ", [3, 10]=>" 1 ", [4, 1]=>" X ", [4, 2]=>" 1 ",
           [4, 3]=>" 1 ", [4, 4]=>" X ", [4, 5]=>" 1 ", [4, 6]=>" O ",
           [4, 7]=>" O ", [4, 8]=>" 1 ", [4, 9]=>" X ", [4, 10]=>" 1 ",
           [5, 1]=>" 2 ", [5, 2]=>" 2 ", [5, 3]=>" 2 ", [5, 4]=>" 1 ",
           [5, 5]=>" 1 ", [5, 6]=>" O ", [5, 7]=>" O ", [5, 8]=>" 1 ",
           [5, 9]=>" 1 ", [5, 10]=>" 1 ", [6, 1]=>" 2 ", [6, 2]=>" X ",
           [6, 3]=>" 2 ", [6, 4]=>" O ", [6, 5]=>" O ", [6, 6]=>" O ",
           [6, 7]=>" O ", [6, 8]=>" 1 ", [6, 9]=>" 1 ", [6, 10]=>" 1 ",
           [7, 1]=>" 2 ", [7, 2]=>" X ", [7, 3]=>" 3 ", [7, 4]=>" 1 ",
           [7, 5]=>" 1 ", [7, 6]=>" O ", [7, 7]=>" O ", [7, 8]=>" 1 ",
           [7, 9]=>" X ", [7, 10]=>" 1 ", [8, 1]=>" 1 ", [8, 2]=>" 1 ",
           [8, 3]=>" 2 ", [8, 4]=>" X ", [8, 5]=>" 1 ", [8, 6]=>" O ",
           [8, 7]=>" O ", [8, 8]=>" 1 ", [8, 9]=>" 1 ", [8, 10]=>" 1 ",
           [9, 1]=>" O ", [9, 2]=>" O ", [9, 3]=>" 1 ", [9, 4]=>" 1 ",
           [9, 5]=>" 1 ", [9, 6]=>" O ", [9, 7]=>" O ", [9, 8]=>" O ",
           [9, 9]=>" 1 ", [9, 10]=>" 1 ", [10, 1]=>" O ", [10, 2]=>" O ",
           [10, 3]=>" O ", [10, 4]=>" O ", [10, 5]=>" O ", [10, 6]=>" O ",
           [10, 7]=>" O ", [10, 8]=>" O ", [10, 9]=>" 1 ", [10, 10]=>" X "}
       display(@solution.board)
   end
   
    def flag(position)
        @board[[position[0], position[1]]] = " F " if @board[[position[0], position[1]]] == " # "
        display(@board)
    end
    
    def deflag(position)
        @board[[position[0], position[1]]] = " # " if @board[[position[0], position[1]]] == " F "
        display(@board)
    end
    
    def click(position)
        @board.each do |key, value|
           @testbench[key] = " X " if value == " F "
        end
        if @solution.board[position] == " X "
            abort "you lose" 
        else
            dig(position) if @testbench[position] != "X"
        end
        
        @testbench.each do |key, item|
            @board[key] = @testbench[key] unless @testbench[key] == " X "
        end
        
        display(@board)
        
    end
    
    def dig(position)
       
       if @solution.board[position] != " O "
           @testbench[position] = @solution.board[position] 
       end
       
       if @solution.board[position] == " O " && @testbench[position] != " X "
          @testbench[position] = @solution.board[position]
          top = [position[0]+1, position[1]]
          bottom = [position[0]-1, position[1]]
          left = [position[0], position[1]-1]
          right = [position[0], position[1]+1]
          @testbench[top] = @solution.board[top] if @solution.board[top] == " X " && @testbench[top] != @solution.board[top]
          @testbench[bottom] = @solution.board[bottom] if @solution.board[bottom] == " X " && @testbench[bottom] != @solution.board[bottom]
          @testbench[left] = @solution.board[left] if @solution.board[left] == " X " && @testbench[left] != @solution.board[left]
          @testbench[right] = @solution.board[right] if @solution.board[right] == " X " && @testbench[right] != @solution.board[right]
          dig(top) if @solution.board[top] != " X " && @testbench[top] != @solution.board[top]
          dig(bottom) if @solution.board[bottom] != " X " && @testbench[bottom] != @solution.board[bottom]
          dig(left) if @solution.board[left] != " X " && @testbench[left] != @solution.board[left]
          dig(right) if @solution.board[right] != " X " && @testbench[right] != @solution.board[right]
       end
        
    end
    
    def display(hash_board)
       puts"---------------------------"
       hash_board.each do |key, value|
          print value
          print "\n" if key[1] == @length
       end
       puts"--------------------------"
    end
    
    def compare(hash_board, hash_solution)
        flag_bag = []
        mines_bag = []
        hash_board.each do |key, value|
            if hash_board[key] == " F "
                flag_bag << key
            end
        end
        hash_solution.each do |key, value|
            if hash_solution[key] == " X "
                mines_bag << key
            end
        end
        print flag_bag.sort 
        print mines_bag.sort
        if flag_bag.sort != mines_bag.sort
            return "not win yet"
        else
            return "you win"
        end
    end
end
=begin
i = Interface.new

i.display(i.solution.board)

i.display(i.board)

i.click([2,2])
=end
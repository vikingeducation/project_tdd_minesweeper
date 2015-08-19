class Solution
    attr_accessor :width, :length, :mines, :board
    
    def initialize(matrix)
        @width = matrix[0]
        @length = matrix[1]
        @mines = []
        @board = {}
        setting(@length, @width)
    end
    
    def setting(l, w)
       while mines.length != (((@width * @length) / 10) - 1) do
          x = Random.rand(1..w)
          y = Random.rand(1..l)
          mines << [x, y] unless mines.include?([x, y])
       end
       layout(mines)
    end
    
    def layout(mines)
       1.upto(@width) do |w|
           1.upto(@length) do |l|
               @board[[w,l]] = " O " unless mines.include?([w,l])
               @board[[w,l]] = " X " if mines.include?([w,l])
               #print "\n" if w == @width
           end
       end
       @board = givenumber(@board)
       #print @board
       
    end
        
    def givenumber(hash)
       hush = {}
       hush = hash
       hash.each do |key, value|
          hush[key] = aroundcheck(hash, key) if (value == " O ") && (aroundcheck(hash, key).to_i > 0)
       end
       #below are just for game test
       hush.each do |key, value|
           print value
           print "\n" if key[1] == @length
       end
       hush
    end
    
    def aroundcheck(hash, key)
        num = 0
        num += 1 if hash[[(key[0]-1), (key[1]+1)]] == " X "
        num += 1 if hash[[(key[0]-1), (key[1])]] == " X "
        num += 1 if hash[[(key[0]-1), (key[1]-1)]] == " X "
        num += 1 if hash[[(key[0]), (key[1]+1)]] == " X "
        num += 1 if hash[[(key[0]), (key[1]-1)]] == " X "
        num += 1 if hash[[(key[0]+1), key[1]+1]] == " X "       
        num += 1 if hash[[(key[0]+1), key[1]]] == " X "
        num += 1 if hash[[(key[0]+1), (key[1]-1)]] == " X "
        #print num
        return " "+num.to_s+" "
    end
    
    def soluprint
       @board.each do |key, value|
           print value
           print "\n" if key[0] == @width
       end
    end
    
end
#CAUTION, the width length is reversed
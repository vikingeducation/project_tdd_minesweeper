class Board 

	attr_reader :board_arr

	def initialize( boar_arr = nil)
		#set up blank data structure
		@board_arr = Array.new(10) {Array.new(10)}
	end

	def render
		puts
		@board_arr.each do |row|
			row.each do |cell|
				#display an existing marker if any, else blank
				cell.nil? ? print("-") : print(cell.to_s)
			end
			puts
		end
		puts
	end
end

b = Board.new
b.render
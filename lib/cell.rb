class Cell

	attr_accessor :state, :content

	def initialize
		@state = :closed
		@content = :empty
		@symbols = 	{ 
				"8".to_sym 	=> " 8️⃣   ",
     			"7".to_sym  => " 7️⃣   ",
     			"6".to_sym  => " 6️⃣   ",
     			"5".to_sym 	=> " 5️⃣   ",
     			"4".to_sym 	=> " 4️⃣   ",
     			"3".to_sym 	=> " 3️⃣   ",
     			"2".to_sym 	=> " 2️⃣   ",
     			"1".to_sym 	=> " 1️⃣   ",
     			:mine    	=>" 💣   ",
     			:flagged 	=> " ⛳️   ",
     			:closed  	=>  " ⬜   ",
     			:empty   	=>	 "     "
 			}
	end

	def render
		print @symbols[@content] if @state == :opened
		print @symbols[@state] if @state != :opened
	end

	def is_mine
		@content == :mine
	end

	private

end
require 'pry'


class Render


	def render_board( board )

		num = 1

		board.each do | x |

			print "#{num}".ljust( 2 )

			 x.each do | y |

			 	print "#{y}".rjust( 3 )

			 end

			 puts ""

			 num += 1

		end

		render_footer

	end



	def render_flags( flags )

		puts "Flags: #{ flags }"

	end


	def render_footer

		print "----------------------------------"
		puts ""
		print "    1  2  3  4  5  6  7  8  9  10"

		puts ""


	end


	def self.render_message( message )

		puts message

	end



	def self.prompt_for_move

		puts "Please enter what you'd like to do."
		puts "1. Clear Square"
		puts "2. Place Flag"
		puts "3. Remove Flag"
		puts "4. Quit Game"

	end

end

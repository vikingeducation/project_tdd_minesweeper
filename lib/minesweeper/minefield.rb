require 'colorize'

class Minefield
	attr_accessor :state, :size

	def initialize(options={})
		@size = options[:size] || 10
		self.state = options[:state] || blank_state
	end

	def state=(value)
		@state = format_state(value)
	end

	def each_adjacent(x, y)
		coordinates = adjacents(x, y)
		coordinates.each do |c|
			x = c[1]
			y = c[0]
			yield(x, y)
		end
	end

	def adjacents(x, y)
		[
			[y - 1, x - 1],
			[y - 1, x + 1],
			[y + 1, x - 1],
			[y + 1, x + 1],
			[y, x - 1],
			[y, x + 1],
			[y - 1, x],
			[y + 1, x]
		]
	end

	def to_s
		x_numbers = '   '
		rows = []
		@state.each_with_index do |y_value, y_index|
			x_numbers += " #{y_index.next}  ".colorize(:white)
			row = [
				y_index.next.to_s.ljust(2).colorize(:white)
			]
			y_value.each do |x_value|
				row << "[#{x_value}]"
			end
			rows << row.join(' ')
		end
		rows.unshift(x_numbers)
		rows.join("\n")
			.gsub(/F/, 'F'.colorize(:green))
			.gsub(/M/, 'M'.colorize(:red))
			.gsub(/\[0\]/, '[ ]')
	end

	def format_state(state)
		formatted = state
		if state.is_a?(Array)
			formatted = decompress(state) if state.all? {|r| r =~ /^[\-0-9MFC]{10}$/}
		elsif state.is_a?(String)
			formatted = denormalize(state) if state =~ /^[\-0-9MFC]{#{@size**2}}$/
		else
			raise "Invalid state"
		end
		formatted
	end

	def blank_state
		Array.new(@size){Array.new(@size){0}}
	end

	def normalize
		str = ''
		@state.each do |row|
			str += row.reduce('') {|sum, square| sum += square.to_s}
		end
		str
	end

	def denormalize(str)
		array = str.chars.each_slice(@size).to_a
		array = array.map {|r| r.map {|s| s =~ /[0-9]/ ? s.to_i : s}}
	end

	def compress
		compressed = []
		@state.each do |row|
			compressed << row.join
		end
		compressed
	end

	def decompress(array)
		decompressed = []
		array.each do |row|
			decompressed << row.split('')
				.map! {|i| i =~ /[0-9]/ ? i.to_i : i }
		end
		decompressed
	end

	def in_bounds?(x, y)
		[
			(y >= 0),
			(y < @size),
			(x >= 0),
			(x < @size)
		].all? {|r| r == true}
	end
end
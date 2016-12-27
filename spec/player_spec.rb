require "player"

describe Player do

	let(:player) {Player.new}

	describe '#initialize' do

		it 'sets the player attributes properly' do
			#expect(viking.name).to eq("Behdad")
		end

	end

	describe '#move' do

		it 'loops when bad input received1' do
			expect(player).to receive(:gets).and_return("oen", "open 1 2")
			player_move = player.get_command(10,10)
			command = player_move[0]
			expect(command).to eq("open")
		end

		it 'loops when bad input received2' do
			expect(player).to receive(:gets).and_return("flag 3 15", "open 3 2")
			player_move = player.get_command(10,10)
			command = player_move[0]
			expect(command).to eq("open")
		end

		it 'loops when bad input received3' do
			expect(player).to receive(:gets).and_return("flag 30 1", "flag -1 1", "flag 0", "flag 3 4")
			player_move = player.get_command(10,10)
			command = player_move[0]
			expect(command).to eq("flag")
		end

		it 'gets a good open command from player' do
			expect(player).to receive(:gets).and_return("open 2 3")
			player_move = player.get_command(10,10)
			command = player_move[0]
			row = player_move[1]
			column = player_move[2]
			expect(command).to eq("open")
			expect(row).to eq("2")
			expect(column).to eq("3")
		end

		it 'gets a good flag command from player' do
			expect(player).to receive(:gets).and_return("flag 8 7")
			player_move = player.get_command(10,10)
			command = player_move[0]
			row = player_move[1]
			column = player_move[2]
			expect(command).to eq("flag")
			expect(row).to eq("8")
			expect(column).to eq("7")
		end

		it 'gets a good deflag command from player' do
			expect(player).to receive(:gets).and_return("deflag 6 1")
			player_move = player.get_command(10,10)
			command = player_move[0]
			row = player_move[1]
			column = player_move[2]
			expect(command).to eq("deflag")
			expect(row).to eq("6")
			expect(column).to eq("1")
		end

		it 'gets a good quit command from player' do
			expect(player).to receive(:gets).and_return("quit")
			player_move = player.get_command(10,10)
			command = player_move[0]
			row = player_move[1]
			column = player_move[2]
			expect(command).to eq("quit")
		end
	end

end
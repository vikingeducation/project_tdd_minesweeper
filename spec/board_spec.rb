require 'spec_helper'
require 'game'

describe Board do 

	it "is a board" do 
		expect(subject).to be_a(Board)
	end

	it "accepts a board array on initialize" do
	  expect do 
	  	Board.new( Array.new(10) { Array.new(10) } )
	  end.not_to raise_error
	end

	describe "#render" do
	  it "displays empty board at the beginning" do 
	  	expect {subject.render}.to output("\n----------\n----------\n----------\n----------\n----------\n----------\n----------\n----------\n----------\n----------\n\n").to_stdout
	  end 
	end

end
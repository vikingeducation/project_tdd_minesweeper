require_relative '../lib/solution'

describe "Solution make" do
let(:sol){Solution.new([10,10])}
let(:testhash){{
[1, 1]=>" X ", [2, 1]=>" O ", [3, 1]=>" O ",
[1, 2]=>" O ", [2, 2]=>" O ", [3, 2]=>" X ", 
[1, 3]=>" O ", [2, 3]=>" O ", [3, 3]=>" O "}}
   it "initilize matrix" do
       expect(sol.width).to eq(10)
       expect(sol.length).to eq(10)
   end
   
   it "(1/10)-1 of the whole square are mines" do
       expect(sol.mines.length).to eq(9)
   end
   
   it "aroundcheck check each corner of a single square to give the surrounded number" do
       expect(sol.aroundcheck(testhash, [2,2])).to eq(" 2 ")
       expect(sol.aroundcheck(testhash, [2,1])).to eq(" 2 ")
       expect(sol.aroundcheck(testhash, [2,3])).to eq(" 1 ")
   end
end

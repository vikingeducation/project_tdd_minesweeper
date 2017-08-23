RSpec.describe Minesweeper::Renderer do
  let(:renderer) { Minesweeper::Renderer.new }

  describe '#render' do
    it 'raises error when board or mode is not given' do
      expect{renderer.render}.to raise_error(ArgumentError)
      expect{renderer.render('')}.to raise_error(ArgumentError)
      expect{renderer.render(Minesweeper::Board.new)}.to raise_error(ArgumentError)
    end

    it 'does not raise when board given' do
      expect{renderer.render(Minesweeper::Board.new, :active)}.not_to raise_error
    end
  end
end

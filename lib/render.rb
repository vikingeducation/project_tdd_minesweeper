module Render
  SMILING_FACE = "[#{"\u{1F604}".center(4)}]"
  UPSET_FACE = "[#{"\u{1F621}".center(4)}]"
  SMILING_FACE_WITH_SUNGLASSES = "[#{"\u{1F60E}".center(4)}]"
  HOURGLASS = "\u23F3".center(4)
  BOMB = "\u{1F4A3}".center(4)
  BOMB_RB = "\e[101m#{BOMB}\e[0m"
  FLAG = "\u26F3".center(4)
  EMPTY_CELL = ''.ljust(4)
  CLEARED_CELL = "\e[107m#{''.ljust(4)}\e[0m" 
  
  def self.cleared_cell(num) 
    "\e[1;47m#{num.to_s.center(4)}\e[0m" 
  end
end
module Instructions
  def render_welcome
    title = "* Welcome to Minesweeper! * "
    puts "* " * (title.length / 2)
    puts title
    puts "* " * (title.length / 2), ""
    puts "Try to uncover the board by entering the coordinates"
    puts "of the cells without mines in them.",""
    request_continue
  end

  def render_instructions
    clear_terminal
    puts "This is a blank board:"
    puts "     1   2   3   4   5   6   7   8   9   10"
    puts "  -------------------------------------------"
    puts "A |  .   .   .   .   .   .   .   .   .   .  |"
    puts "  |                                         |"
    puts "B |  .   .   .   .   .   .   .   .   .   .  |"
    puts "  |                                         |"
    puts "C |  .   .   .   .   .   .   .   .   .   .  |"
    puts "  |                                         |"
    puts "D |  .   .   .   .   .   .   .   .   .   .  |"
    puts "  |                                         |"
    puts "E |  .   .   .   .   .   .   .   .   .   .  |"
    puts "  |                                         |"
    puts "F |  .   .   .   .   .   .   .   .   .   .  |"
    puts "  |                                         |"
    puts "G |  .   .   .   .   .   .   .   .   .   .  |"
    puts "  |                                         |"
    puts "H |  .   .   .   .   .   .   .   .   .   .  |"
    puts "  |                                         |"
    puts "I |  .   .   .   .   .   .   .   .   .   .  |"
    puts "  |                                         |"
    puts "J |  .   .   .   .   .   .   .   .   .   .  |"
    puts "  -------------------------------------------", ""
    puts "You'll get clues about the number of mines appearing in"
    puts "the cells immediately surrounding any given cell."
    request_continue
    clear_terminal
    puts "Look at cell C4. Of the cells directly surrounding it (x),"
    puts "it has only 1 mine (M). This is why C4 has a 1 in it."
    puts "Similarly, G6 has a 2 in it.", ""
    puts "     1   2   3   4   5   6   7   8   9   10"
    puts "  -------------------------------------------"
    puts "A |  .   .   .   .   .   .   .   .   .   .  |"
    puts "  |                                         |"
    puts "B |  .   .   x   x   x   .   .   .   .   .  |"
    puts "  |                                         |"
    puts "C |  .   .   x   1   x   M   .   .   .   .  |"
    puts "  |                                         |"
    puts "D |  .   .   x   M   x   .   .   .   .   .  |"
    puts "  |                                         |"
    puts "E |  .   .   .   .   .   .   .   .   .   .  |"
    puts "  |                                         |"
    puts "F |  .   .   .   .   x   x   x   .   .   .  |"
    puts "  |                                         |"
    puts "G |  .   .   .   .   x   2   x   .   .   .  |"
    puts "  |                                         |"
    puts "H |  .   .   .   .   x   M   M   .   .   .  |"
    puts "  |                                         |"
    puts "I |  .   .   .   .   .   .   .   .   .   .  |"
    puts "  |                                         |"
    puts "J |  .   .   .   .   .   .   .   .   .   .  |"
    puts "  -------------------------------------------", ""
    request_continue
    clear_terminal
    puts "When you enter cell coordinates, you'll get number"
    puts "feedback just like this. Your goal is to clear the"
    puts "board without entering the coordinates of any mines."
    request_continue
    clear_terminal
  end

  def request_continue
    puts "Hit Enter to continue"
    gets.chomp
  end

  def clear_terminal
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

end
require 'colorize'

class ShellPresenter
  def red_message(msg)
    puts msg.colorize :red
  end

  def green_message(msg)
    print msg.colorize :green
  end
end


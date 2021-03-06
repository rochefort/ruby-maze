require "ruby_maze/keyboard"
require "ruby_maze/maze"
require "ruby_maze/version"

class RubyMaze
  def initialize(size)
    @maze = Maze.new(size)
  end

  def run
    while true
      key = Keyboard.read_key
      exec(key)
    end
  end

  private
    def exec(key)
      case key
      when "q", "\u0003"
        # q or control-c
        exit()
      when "R"
        @maze.reset()
      when "N"
        @maze.renew()
      when "H"
        @maze.help()
      else
        @maze.execute(key)
      end
    end
end

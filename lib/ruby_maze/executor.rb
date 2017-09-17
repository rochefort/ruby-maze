class RubyMaze
  class Executor
    def initialize(size)
      @maze = RubyMaze::Maze.new(size.to_i)
    end

    def exec(key)
      case key
      when "q", "\u0003"
        # q or control-c
        fail()
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
end

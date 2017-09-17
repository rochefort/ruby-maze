require "ruby_maze/executor"
require "ruby_maze/keyboard"
require "ruby_maze/maze"
require "ruby_maze/version"

class RubyMaze
  def run(size)
    executor = Executor.new(size)
    while true
      key = Keyboard.read_key
      executor.exec(key)
    end
  end
end

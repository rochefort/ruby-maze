class RubyMaze
  class Maze
    module Rendering
      extend self

      private
        def render(maze)
          puts "\e[H\e[2J"
          maze.each do |line|
            # nil:    壁 => `[]`
            # true:   道 => `  `
            # その他: goal or user => `GO` or `**`
            puts (line.map do |s|
              next "[]" if s.nil?
              next "  " if s == true
              s
            end).join
          end
        end

        def render_usage
          puts <<-EOS

----------------------------------------------
Usage:

** in the lower left is YOU.
GO in the upper right is GOAL.

Press the w or Up-arrow    key to move UP.
Press the s or Down-arrow  key to move DOWN.
Press the a or Left-arrow  key to move LEFT.
Press the d or Right-arrow key to move RIGHT.

Press the q or Control-c key to quit game.

Press the R key to RESTART game.
Press the N key to start NEW game.
Press the H key to look at this.

EOS
        end

        def render_finish
          seconds = (Time.now - @start).floor(3)
          puts <<-EOS

+-+-+-+-+-+-+-+-+-+
|C o n g r a t s !|
+-+-+-+-+-+-+-+-+-+

Your time is #{seconds} seconds.
EOS
        end
    end
  end
end

require "ruby_maze/maze/rendering"

class RubyMaze
  # Keyboard
  #   UP    : `Up-arrow`    or `w`
  #   Down  : `Down-arrow`  or `s`
  #   Right : `Right-arrow` or `a`
  #   Left  : `Down-arrow`  or `d`
  #
  #   Quit  : `q` or `control-c`
  #
  #   Reset : `R`
  #   Renew : `N`
  #   Help  : `H`

  class Maze
    include Rendering
    DIRECTION_UP    = 0
    DIRECTION_DOWN  = 1
    DIRECTION_RIGHT = 2
    DIRECTION_LEFT  = 3
    DIRECTIONS = [DIRECTION_UP, DIRECTION_DOWN, DIRECTION_RIGHT, DIRECTION_LEFT]

    MOVE_KEYS = {
      DIRECTION_UP    => ["w", "k", "\e[A"],
      DIRECTION_DOWN  => ["s", "j", "\e[B"],
      DIRECTION_RIGHT => ["a", "l", "\e[C"],
      DIRECTION_LEFT  => ["d", "h", "\e[D"],
    }

    def initialize(size)
      @start = Time.now
      @maze = []
      @path_pos = []
      @user_pos = []
      @goal_pos = []
      @paths = []
      @size = size
      create_maze
      render(@maze)
      render_usage
      puts "GAME START!!"
    end

    def execute(key)
      return unless MOVE_KEYS.values.flatten.include?(key)
      direction = MOVE_KEYS.find { |_d, keys| keys.include?(key) }.to_a[0]
      next_pos = next_position(direction, @user_pos)
      return if wall?(next_pos)

      if @goal_pos == next_pos
        render_finish
        exit()
      else
        move_user(next_pos)
        render(@maze)
      end
    end

    def reset
      change_maze(@user_pos, "  ")
      setup_start
      render(@maze)
    end

    def renew
      initialize(@size)
    end

    def help
      render(@maze)
      render_usage
    end

    private
      # 壁かどうか?
      #   壁: nil
      #   道: true
      #   その他: goal or user
      def wall?(position)
        @maze[position[0]][position[1]] == nil
      end

      def create_maze
        # 「壁」: nil として生成
        @maze = Array.new(@size) { Array.new(@size) }

        # 外側を除いた場所からランダムに探索開始位置を選択
        row = rand(@size - 2) + 1
        col = rand(@size - 2) + 1
        extend_path(row, col)

        # 探索
        begin
          extend_paths
        end while extendable_paths?

        setup_start
        setup_goal
      end

      # 過去に配置した「道」から再探索可能かどうかを評価する
      def extendable_paths?
        while !@paths.empty?
          @path_pos = @paths.pop
          if DIRECTIONS.any? { |direction| extendable_path?(direction) }
            return true
          end
        end
        false
      end

      def extendable_path?(direction)
        row, col = next_position(direction, @path_pos)
        return count_surrounding_path(row, col) == 1
      end

      def extend_paths
        do_extend = true
        while do_extend
          extended = false
          directions = DIRECTIONS.to_a.shuffle.each do |direction|
            if extendable_path?(direction)
              row, col = next_position(direction, @path_pos)
              extend_path(row, col)
              extended = true
              break
            end
          end
          do_extend = extended
        end
      end

      def extend_path(row, col)
        @path_pos = row, col
        change_maze(@path_pos, true)
        @paths.push(@path_pos)
      end

      def change_maze(position, value)
        @maze[position[0]][position[1]] = value
      end

      def next_position(direction, position)
        row = position[0]
        col = position[1]
        case direction
        when DIRECTION_UP    then row -= 1
        when DIRECTION_DOWN  then row += 1
        when DIRECTION_RIGHT then col += 1
        when DIRECTION_LEFT  then col -= 1
        end
        [row, col]
      end

      def count_surrounding_path(row, col)
        num = 0
        num += 1 if (row == 0         || @maze[row - 1][col])
        num += 1 if (row == @size - 1 || @maze[row + 1][col])
        num += 1 if (col == 0         || @maze[row][col - 1])
        num += 1 if (col == @size - 1 || @maze[row][col + 1])
        num
      end

      def setup_start
        row = @size - 1
        col = 1
        while true
          break if @maze[row - 1][col]
          col += 1
        end
        @user_pos = [row, col]
        change_maze(@user_pos, "**")
      end

      def setup_goal
        row = 0
        col = @size - 2
        while true
          break if @maze[row + 1][col]
          col -= 1
        end
        @goal_pos = [row, col]
        change_maze(@goal_pos, "GO")
      end

      def move_user(next_pos)
        change_maze(@user_pos, "  ")
        @user_pos = next_pos
        change_maze(@user_pos, "**")
      end
  end
end

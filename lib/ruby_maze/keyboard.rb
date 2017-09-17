class RubyMaze
  class Keyboard
    def self.read_key
      begin
        system("stty raw -echo")
        c = STDIN.getc
        if c == "\e"
          thread = Thread.new {
            c += STDIN.getc.chr
            c += STDIN.getc.chr
          }
          thread.join()
        end
      ensure
        system("stty -raw echo")
      end
      c
    end
  end
end

# Ruby::Maze

[hey-cube/maze](https://github.com/hey-cube/maze) のruby実装です。  


## Installation

    $ git clone https://github.com/rochefort/ruby-maze
    $ cd ruby-maze
    $ bundle install
    $ bundle exec rake install
    # if you use rbenv:
    $ rbenv rehash

## Usage

    $ ruby-maze 20

```
[][][][][][][][][][][][][][][][]GO[][][]
[]    []      []    []            [][][]
[]  [][]  []      []    [][]  []    [][]
[]          [][]      []      [][]    []
[]  [][][]      [][][][]  []    [][]  []
[]        [][]  []      []    []      []
[][][][]    [][]    []    [][]    []  []
[]    [][]    []  [][][]  []  []  []  []
[]  []    []  []    []    []      []  []
[]      []      []    []  [][]  [][]  []
[]  []      []  []  []  []        []  []
[]    [][][]  [][]        []  []  [][][]
[][]      []      [][][]    []        []
[]  [][]  []  []        []  []  [][]  []
[]  [][]  []    []  []  []    [][][]  []
[]        []  []    []    []    []    []
[]  [][][]  []    []  []    []      [][]
[]      []      [][]  [][]    [][]    []
[]  []      []            []      []  []
[]**[][][][][][][][][][][][][][][][][][]

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

GAME START!!
```

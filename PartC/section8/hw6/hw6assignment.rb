# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
    # The constant All_My_Pieces holds the all 10 pieces
    All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
                    rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
                    [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
                    [[0, 0], [0, -1], [0, 1], [0, 2]]],
                    rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
                    rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
                    rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
                    rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
                    rotations([[0, 0], [0, 1], [1, 1], [0, 0]]),    # small L
                    [[[0, 0], [-1, 0], [1, 0], [2, 0], [3, 0]], # Long bar (only needs 2)
                    [[0, 0], [0, -1], [0, 1], [0, 2], [0, 3]]],
                    rotations([[0, 0], [0, 1], [1, 1], [-1, 0], [-1, 1]])]  # square w/ extension

    # Cheat_Piece = [[0,0]] # just one square box

    # My enhancements
    
  
  end
  
  class MyBoard < Board
    # your enhancements here
    
    def rotate_oneEighty
        if !game_over? and @game.is_running?
          @current_block.move(0, 0, 1)
          @current_block.move(0, 0, 1)
        end
        draw
    end
  end
  
  class MyTetris < Tetris
    # My enhancements here
    def set_board
        @canvas = TetrisCanvas.new
        @board = MyBoard.new(self)
        @canvas.place(@board.block_size * @board.num_rows + 3,
        @board.block_size * @board.num_columns + 6, 24, 80)
        @board.draw
    end
    # 1. 'U' to rotate 180 degree
    def key_bindings
        super
        @root.bind('u', proc {@board.rotate_oneEighty})
    end
    def buttons
        super
        rotate_one = TetrisButton.new('(_.', 'lightgreen'){@board.rotate_oneEighty}
        rotate_one.place(35, 50, 27, 501)
    end
  
  end
  
  
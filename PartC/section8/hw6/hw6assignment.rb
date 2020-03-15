# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
    # The constant All_My_Pieces holds the all 10 pieces
    All_My_Pieces = All_Pieces +
                    [rotations([[0, 0], [-1, 0], [-1, -1], [0, -1], [1, 0]]),
                    [[[0, 0], [-1, 0], [-2, 0], [1, 0], [2, 0]],
                    [[0, 0], [0, -1], [0, -2], [0, 1], [0, 2]]],
                    rotations([[0, 0], [0, -1], [1, 0]])]

    Cheat_Piece = [[[0, 0]]] # just one square box

    # My enhancements
    def self.next_piece(board)
        MyPiece.new(All_My_Pieces.sample, board)
    end

    def self.next_cheat_piece(board)
        MyPiece.new(Cheat_Piece, board)
    end
  end
  
  class MyBoard < Board
    # your enhancements here
    def initialize (game)
        @grid = Array.new(num_rows) {Array.new(num_columns)}
        @current_block = MyPiece.next_piece(self)
        @score = 0
        @game = game
        @delay = 500
        @cheat = false
    end

    def rotate_180
        if !game_over? and @game.is_running?
          @current_block.move(0, 0, 2)
        end
        draw
    end

    def init_cheat
        if !@cheat and @score >= 100
            @cheat = true
            @score -= 100
        end
    end

    def next_piece
        if @cheat
            @current_block = MyPiece.next_cheat_piece(self)
            @cheat = false
        else
            @current_block = MyPiece.next_piece(self)
        end
        @current_pos = nil
    end

    def store_current
        locations = @current_block.current_rotation
        displacement = @current_block.position
        (0..(locations.size - 1)).each{|index| 
            current = locations[index];
            @grid[current[1]+displacement[1]][current[0]+displacement[0]] = @current_pos[index]
        }
        remove_filled
        @delay = [@delay - 2, 80].max
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
    def key_bindings
        super
        @root.bind('u', proc {@board.rotate_180})
        @root.bind('c', proc {@board.init_cheat})
    end
    def buttons
        super
        rotate_one = TetrisButton.new('(_.', 'lightgreen'){@board.rotate_180}
        rotate_one.place(35, 50, 27, 501)

        cheat_btn = TetrisButton.new('C', 'lightgreen'){@board.init_cheat}
        cheat_btn.place(35, 50, 127, 571)
    end
  end
  
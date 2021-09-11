module Slideable
  LINEAR_DIRS = [[1,0], [-1,0], [0, 1], [0,-1]]
  DIAGONAL_DIRS = [[-1,1], [-1,-1], [1,-1], [1,1]]
  
  
  def moves
    possible_moves = []
    move_dirs.each do |dir|
      dy, dx = dir # flipped logic
      possible_moves += grow_unblocked(pos, dx, dy)
    end
    possible_moves
  end

  def grow_unblocked(p, dx, dy)
    new_pos = [p.first + dx, p.last + dy]
    return [] if !board.valid_pos?(new_pos)
    return [] unless board[new_pos].is_a?(NullPiece)
    [new_pos] + grow_unblocked(new_pos, dx, dy)
  end

end


require_relative "piece"
require_relative "slideable"

class Queen < Piece
    
include Slideable


  def initialize(color, board, pos)
    super
    @symbol = " ♛ "
  end

  def move_dirs
    DIAGONAL_DIRS + LINEAR_DIRS
  end
end
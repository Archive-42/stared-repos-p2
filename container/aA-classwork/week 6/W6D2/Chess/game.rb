require_relative 'board'
require_relative 'cursor'
require_relative 'display'
class Game

    attr_reader :display, :player1, :player2, :current_player, :board

    def initialize
       @board = Board.new
       @display = Display.new(@board)
       @player1 = HumanPlayer.new(:cyan, @display)
       @player2 = HumanPlayer.new(:yellow, @display)
       @current_player = @player1
    end

    def play
        until @board.checkmate?(@current_player.color)
           start_pos = nil
            until start_pos
                @display.render
                start_pos = @current_player.make_move
                if !start_pos.nil? && @board[start_pos].color != @current_player.color
                    puts "Wrong player color"
                    sleep(1)
                    start_pos = nil
                end
            end
            finish_pos = nil
            until finish_pos
                @display.render
                finish_pos = @current_player.make_move
            end
            swap_turn if @board.move_piece(start_pos,finish_pos)
        end
        @display.render
        puts "Checkmate!"
    end

    private
    def notify_players

    end

    def swap_turn
       @current_player = @current_player == @player1 ? @player2 : @player1
    end

end

class HumanPlayer
    attr_reader :color
    def initialize(color,display)
        #color
        @color = color
        @display = display
    end

    
    def make_move
        @display.cursor.get_input
    end

end

game = Game.new
game.play
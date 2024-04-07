# frozen_string_literal: true

require_relative './board'

# Controls game flow
class ConnectFour
  def initialize(player1 = 'X', player2 = 'O')
    @player1 = player1
    @player2 = player2
    @current_player = @player1
    @board = Board.new
  end

  def pick_column(col_index)
    @board.drop_in_column(col_index, @current_player)
  end

  def game_over?(col_index) = @board.four_complete?(col_index, @current_player)

  def rotate_player
    return @current_player = @player1 if @current_player == @player2

    @current_player = @player2
  end
end

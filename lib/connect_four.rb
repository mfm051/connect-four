# frozen_string_literal: true

require_relative './board'

# Controls game flow
class ConnectFour
  def initialize(player1 = 'X', player2 = 'O')
    @player1 = player1
    @player2 = player2
    @current_player = @player1
    @current_column = nil
    @board = Board.new
  end

  def pick_column
    puts 'Pick a column'
    @current_column = gets.chomp.to_i
    @board.drop_in_column(@current_column, @current_player)
  rescue StandardError => e
    puts e.message
    retry
  end

  def game_over? = @board.four_complete?(@current_column, @current_player)

  def rotate_player
    return @current_player = @player1 if @current_player == @player2

    @current_player = @player2
  end

  def game_round
    puts @board
    puts "Current player: #{@current_player}"
    pick_column
    return puts "#{@current_player} wins!" if game_over?

    rotate_player
    puts "It's a draw!" if @board.full?
  end
end

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

  def game_over?
    return false if @current_column.nil?

    @board.four_complete?(@current_column, @current_player)
  end

  def rotate_player
    return @current_player = @player1 if @current_player == @player2

    @current_player = @player2
  end

  def game_round
    @board.show
    puts "\nCurrent player: #{@current_player}\n\n"
    pick_column
    return winner_greeting if game_over?

    rotate_player
    puts "It's a draw!" if @board.full?
  end

  private

  def winner_greeting
    puts "\n#{@current_player} wins!\n\n"
    @board.show
  end
end

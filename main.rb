# frozen_string_literal: true

require_relative './lib/connect_four'

puts <<~INTRO
  --Connect Four--

  You must choose one of the 7 columns (from 0 to 6, mind you) to drop your 'disc'

  Players alternate until one completes a four-mark sequence or board is full

  ----------------
INTRO

sleep 2

game_start = true

while game_start == true
  game = ConnectFour.new
  game.game_round until game.game_over?

  puts "\nContinue? [y/n]\n"
  game_start = false unless gets.chomp == 'y'
end

puts "\n\nGoodbye o/\n\n"

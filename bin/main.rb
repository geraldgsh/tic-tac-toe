#!/usr/bin/env ruby
require '../lib/engine.rb'

tic_tac_toe = Game.new

p 'Welcome to the Tic-Tac-Toe game'

board = Board.new

while tic_tac_toe.state
  p "Here's the board"
  board.print_board
  p 'Enter cell number where you want to place X'
  user_input = gets.chomp.to_i

  board.change_cell_cross(user_input)

  board.print_board

  p 'Enter cell number where you want to place O'

  user_input = gets.chomp.to_i

  board.change_cell_o(user_input)

  board.print_board

  tic_tac_toe.finish_game
end



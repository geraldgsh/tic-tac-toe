#!/usr/bin/env ruby
require '../lib/engine.rb'

tic_tac_toe = Game.new

p 'Welcome to the Tic-Tac-Toe game'

board = Board.new

checker = InputManipulator.new

while tic_tac_toe.state
  p "Here's the board"
  board.print_board

  user_input = false

  until checker.state
    p 'Enter cell number where you want to place X'
    user_input = gets.chomp.to_i
    checker.check(user_input, board)
  end

  user_input = checker.convert_input(user_input)

  board.change_cell_cross(user_input)

  board.print_board

  checker.reset

  until checker.state
    p 'Enter cell number where you want to place O'
    user_input = gets.chomp.to_i
    checker.check(user_input, board)
  end

  checker.reset

  user_input = checker.convert_input(user_input)

  board.change_cell_o(user_input)

  board.print_board

  tic_tac_toe.finish_game
end



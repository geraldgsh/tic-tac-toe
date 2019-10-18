#!/usr/bin/env ruby
require '../lib/engine.rb'

# Class Game instance
tic_tac_toe = Game.new

p 'Welcome to the Tic-Tac-Toe game'

# Class instance
board = Board.new

# While game is not over
while tic_tac_toe.state
  # Loop for every turn
  p "Here's the board"
  board.print_board
  p 'Player 1 please enter cell number of where you want to place X'

  # Prompts for user input.
  # Prompts error if user input character other than number between 1 to 9
  user_input = gets.chomp.to_i
  board.change_cell_cross(user_input)
  
  # Print the board after receiving user input
  board.print_board
  p 'Player 2 please enter cell number of where you want to place O'

  # Prompts for user input.
  # Prompts error if user input character other than number between 1 to 9
  user_input = gets.chomp.to_i

  board.change_cell_o(user_input)
  board.print_board

  # If game is won or draw. Game state because false which ends the game
  tic_tac_toe.finish_game
end

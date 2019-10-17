#!/usr/bin/env ruby

class Game
  attr_reader :state

  def initialize
    @state = true
  end

  def finish_game
    @state = false
  end
end

class Cell
  attr_reader :state

  def initialize
    @state = nil
  end

  def state
    @state
  end

  def make_cross
    @state = 'X'
  end

  def make_o
    @state = 'O'
  end
end

class Board

  def initialize
    @board_status = {
        1 => Cell.new,
        2 => Cell.new,
        3 => Cell.new,
        4 => Cell.new,
        5 => Cell.new,
        6 => Cell.new,
        7 => Cell.new,
        8 => Cell.new,
        9 => Cell.new
    }
  end

  def change_cell_o(i)
    @board_status[i].make_o
  end

  def change_cell_cross(i)
    @board_status[i].make_cross
  end

  def print_board
    (1..@board_status.length).each do |i|
      print "#{@board_status[i].state.nil? ? i : @board_status[i].state} #{i % 3 == 0 && !i.zero? ? "\n" : ''}"
    end
  end
end

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



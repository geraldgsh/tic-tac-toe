# frozen_string_literal: true

class Game
  attr_reader :state

  attr_reader :counter

  def initialize
    @state = true
    @counter = 0
  end

  def increase_counter
    @counter += 1
  end

  def finish_game
    @state = false
  end

  def line_checker(board, winner)
    return '' unless @counter >= 4

    vertical = vertical(board)

    horizontal = horizontal(board)

    diagonal = diagonal(board)

    if vertical || horizontal || diagonal
      finish_game
      "Player #{winner} won!"
    elsif @counter == 8
      'Draw!'
    end
  end

  def vertical(board)
    board[0][0].state == board[1][0].state && board[1][0].state == board[2][0].state ||
      board[0][1].state == board[1][1].state && board[1][1].state == board[2][1].state ||
      board[0][2].state == board[1][2].state && board[1][2].state == board[2][2].state
  end

  def horizontal(board)
    board[0][0].state == board[0][1].state && board[0][1].state == board[0][2].state ||
      board[1][0].state == board[1][1].state && board[1][1].state == board[1][2].state ||
      board[2][0].state == board[2][1].state && board[2][1].state == board[2][2].state
  end

  def diagonal(board)
    board[0][0].state == board[1][1].state && board[1][1].state == board[2][2].state ||
      board[0][2].state == board[1][1].state && board[1][1].state == board[2][0].state
  end
end

class Cell
  def initialize
    @state = nil
  end

  attr_reader :state

  attr_writer :state

  def make_cross
    @state = 'X'
  end

  def make_o
    @state = 'O'
  end
end

class Board
  attr_reader :board_status

  def initialize
    @board_status = Array.new(3) { Array.new(3) { Cell.new } }
    @board_status.each_with_index do |arr, f_index|
      arr.each_with_index do |elem, s_index|
        print elem.state
        elem.state = (f_index * 3 + s_index + 1).to_s
      end
    end
  end

  def change_cell_o(cell)
    @board_status[cell[0]][cell[1]].make_o
  end

  def change_cell_cross(cell)
    @board_status[cell[0]][cell[1]].make_cross
  end

  def cell_empty?(cell)
    @board_status[cell[0]][cell[1]].state == 'X' || @board_status[cell[0]][cell[1]].state == 'O' ? false : true
  end

  def print_board
    @board_status.each do |arr|
      arr.each do |elem|
        print elem.state
        print ' '
      end
      puts "\n"
    end
  end
end

class InputManipulator
  attr_reader :state

  def initialize
    @state = false
  end

  # Convert user input to array indices
  def convert_input(input)
    first = (input % 3).zero? ? (input / 3) - 1 : (input / 3)
    second = (input - 1) % 3
    [first, second]
  end

  # Input validator
  def check(user_input, board)
    @state = true if (1..9).include?(user_input) && board.cell_empty?(convert_input(user_input)) && !user_input.zero?
  end

  def reset
    @state = false
  end
end

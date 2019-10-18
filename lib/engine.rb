# frozen_string_literal: true

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

  def make_cross
    @state = 'X'
  end

  def make_o
    @state = 'O'
  end
end

class Board
  def initialize
    @board_status = Array.new(3) { Array.new(3) { Cell.new } }
  end

  def change_cell_o(cell)
    p cell
    @board_status[cell[0]][cell[1]].make_o
  end

  def change_cell_cross(cell)
    p cell
    @board_status[cell[0]][cell[1]].make_cross
  end

  def cell_empty?(cell)
    p cell
    p @board_status[cell[0]][cell[1]].state.nil?
    @board_status[cell[0]][cell[1]].state.nil?
  end

  def print_board
    # (0..@board_status.length-1).each do |i|
    #   print "#{@board_status[i].state.nil? ? i : @board_status[i].state} #{(i % 3).zero? && !i.zero? ? "\n" : ''}"
    # end
    @board_status.each_with_index do |arr, f_index|
      arr.each_with_index do |elem, s_index|
        print(elem.state.nil? ? f_index * 3 + s_index + 1 : elem.state).to_s
        print " "
      end
      puts "\n"
    end
  end

  def check_board
    first = 0
    (1..@board_status.length).each do |i|
      (i % 3).zero?
    end
  end
end

class InputManipulator
  attr_reader :state

  def initialize
    @state = false
  end

  def convert_input(input)
    first = (input % 3).zero? ? (input / 3) -1 : (input / 3)
    second = (input - 1) % 3
    [first, second]
  end

  def check(user_input, board)
    @state = false
    @state = true if (1..9).include?(user_input) && board.cell_empty?(convert_input(user_input)) && !user_input.zero?
  end

  def reset
    @state = false
  end
end

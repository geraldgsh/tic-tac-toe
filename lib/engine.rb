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

  def change_cell_o(cell)
    @board_status[cell].make_o
  end

  def change_cell_cross(cell)
    @board_status[cell].make_cross
  end

  def print_board
    (1..@board_status.length).each do |i|
      print "#{@board_status[i].state.nil? ? i : @board_status[i].state} #{(i % 3).zero? && !i.zero? ? "\n" : ''}"
    end
  end
end

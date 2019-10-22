# frozen_string_literal: true

require File.expand_path('./lib/engine')

describe Game do
  describe '#finish_game' do
    it 'changes game state to false' do
      game1 = Game.new
      game1.finish_game
      expect(game1.state).to eq(false)
    end
  end
  describe '#increase_counter' do
    it 'increases the game counter by 1' do
      game1 = Game.new
      game1.increase_counter
      expect(game1.counter).to eq(1)
    end
  end
  describe '#horizontal' do
    context 'Checks if there 3 similar items in the row' do
      it 'Returns true if there are' do
        game1 = Game.new
        board = Board.new
        board.change_cell_cross([1, 0])
        board.change_cell_cross([1, 1])
        board.change_cell_cross([1, 2])
        expect(game1.horizontal(board.board_status)).to eq(true)
      end
      it 'returns false if there aren\'t' do
        game1 = Game.new
        board = Board.new
        board.change_cell_cross([1, 0])
        board.change_cell_cross([1, 1])
        board.change_cell_cross([2, 2])
        expect(game1.horizontal(board.board_status)).to eq(false)
      end
    end
  end
  describe '#vertical' do
    context 'Checks if there 3 similar items in the column' do
      it 'Returns true if there are' do
        game1 = Game.new
        board = Board.new
        board.change_cell_cross([0, 0])
        board.change_cell_cross([1, 0])
        board.change_cell_cross([2, 0])
        expect(game1.vertical(board.board_status)).to eq(true)
      end
      it 'returns false if there aren\'t' do
        game1 = Game.new
        board = Board.new
        board.change_cell_cross([1, 0])
        board.change_cell_cross([1, 1])
        board.change_cell_cross([2, 2])
        expect(game1.vertical(board.board_status)).to eq(false)
      end
    end
  end
  describe '#diagonal' do
    context 'Checks if there 3 similar items in the diagonal' do
      it 'Returns true if there are' do
        game1 = Game.new
        board = Board.new
        board.change_cell_cross([0, 0])
        board.change_cell_cross([1, 1])
        board.change_cell_cross([2, 2])
        expect(game1.diagonal(board.board_status)).to eq(true)
      end
      it 'returns false if there aren\'t' do
        game1 = Game.new
        board = Board.new
        board.change_cell_cross([1, 0])
        board.change_cell_cross([1, 1])
        board.change_cell_cross([2, 2])
        expect(game1.diagonal(board.board_status)).to eq(false)
      end
    end
  end
  describe '#line_checker' do
    context 'Checks if there is a winner or a draw' do
      it 'Returns nothing if counter is less then or equals 4' do
        game1 = Game.new
        board = Board.new
        expect(game1.line_checker(board, 'X')).to eq('')
      end
      it 'Returns won if vertical or diagonal or horizontal is true' do
        game1 = Game.new
        board = Board.new
        board.change_cell_cross([0, 0])
        board.change_cell_cross([1, 1])
        board.change_cell_cross([2, 2])
        game1.increase_counter
        game1.increase_counter
        game1.increase_counter
        game1.increase_counter
        game1.increase_counter
        expect(game1.line_checker(board.board_status, 'X')).to eq('Player X won!')
      end
      it 'Returns draw if counter equals 8' do
        game1 = Game.new
        board = Board.new
        8.times { game1.increase_counter }
        expect(game1.line_checker(board.board_status, 'X')).to eq('Draw!')
      end
    end
  end
end

describe Cell do
  describe '#make_cross' do
    it 'changes Cell state to "X"' do
      cell = Cell.new
      cell.make_cross
      expect(cell.state).to eq('X')
    end
  end
  describe '#make_o' do
    it 'changes Cell state to "O"' do
      cell = Cell.new
      cell.make_o
      expect(cell.state).to eq('O')
    end
  end
end

describe Board do
  it 'Board status after initialization should be cells with state from 1 to 9' do
    board = Board.new
    expect(board.board_status[0][0].state).to eq('1')
  end
  describe '#change_cell_cross' do
    it 'changes Cell state to "X"' do
      board = Board.new
      board.change_cell_cross([0, 0])
      expect(board.board_status[0][0].state).to eq('X')
    end
  end
  describe '#change_cell_p' do
    it 'changes Cell state to "O"' do
      board = Board.new
      board.change_cell_o([0, 0])
      expect(board.board_status[0][0].state).to eq('O')
    end
  end
  describe '#cell_empty?' do
    context 'when the cell is empty' do
      it 'return true' do
        board = Board.new
        expect(board.cell_empty?([0, 0])).to eq(true)
      end
    end
    context 'when the cell isn\'t empty' do
      it 'return false' do
        board = Board.new
        board.change_cell_cross([0, 0])
        expect(board.cell_empty?([0, 0])).to eq(false)
      end
    end
  end
end

describe InputManipulator do
  describe '#convert_input' do
    it 'converts number of cell to it\'s coordinates' do
      manip = InputManipulator.new
      expect(manip.convert_input(4)).to eq([1, 0])
    end
  end
  describe '#check' do
    context 'when user input is not in range from 1 to 9' do
      it 'returns false' do
        board = Board.new
        manip = InputManipulator.new
        manip.check(10, board)
        expect(manip.state).to eq(false)
      end
    end
    context 'when user input can not be converted into integer' do
      it 'returns false' do
        board = Board.new
        manip = InputManipulator.new
        user_input = 'fsodfodspofsdp'
        user_input = user_input.to_i
        manip.check(user_input, board)
        expect(manip.state).to eq(false)
      end
    end
    context 'when chosen cell is already occupied' do
      it 'returns false' do
        board = Board.new
        board.change_cell_cross([1, 0])
        manip = InputManipulator.new
        manip.check(4, board)
        expect(manip.state).to eq(false)
      end
    end
    context 'when everything is alright' do
      it 'returns true' do
        board = Board.new
        manip = InputManipulator.new
        manip.check(4, board)
        expect(manip.state).to eq(true)
      end
    end
  end
  describe '#reset' do
    it 'changes input_manipulator state to true' do
      board = Board.new
      manip = InputManipulator.new
      manip.check(4, board)
      manip.reset
      expect(manip.state).to eq(false)
    end
  end
end

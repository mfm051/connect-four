# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board_empty) { described_class.new }

  describe '#drop_in_column' do
    it 'marks first element available in column' do
      symbol = 'X'
      column_first = board_empty.instance_variable_get(:@columns)[0]
      expect { board_empty.drop_in_column(0, symbol) }.to change { column_first[0] }.to symbol
    end

    context 'when there is already a marked position' do
      subject(:board_one_pos) { described_class.new }
      before { board_one_pos.drop_in_column(0, 'X') }

      let(:column_first) { board_one_pos.instance_variable_get(:@columns)[0] }

      it 'marks next available element' do
        symbol = 'O'
        expect { board_one_pos.drop_in_column(0, symbol) }.to change { column_first[1] }.to symbol
      end

      it 'does not change previous elements' do
        symbol = 'O'
        expect { board_one_pos.drop_in_column(0, symbol) }.not_to(change { column_first[0] })
      end
    end

    context 'when column is full' do
      subject(:board_full_col) { described_class.new }

      before do
        full_col_index = 0
        6.times { board_full_col.drop_in_column(full_col_index, 'X') }
      end

      let(:column_full) { board_full_col.instance_variable_get(:@columns)[0] }

      it 'raises an error' do
        expect { board_full_col.drop_in_column(0, 'X') }.to raise_error ArgumentError
      end
    end

    context 'when given column is out of board' do
      it 'raises an error' do
        expect { board_empty.drop_in_column(7) }.to raise_error ArgumentError
      end
    end
  end

  describe '#last_occupied_position' do
    context 'when column is not empty' do
      subject(:board_col0_2full) { described_class.new }
      before { 2.times { board_col0_2full.drop_in_column(0, 'X') } }

      it 'returns index of last occupied position' do
        expect(board_col0_2full.last_occupied_position(0)).to eq(1)
      end
    end

    context 'when column is empty' do
      subject(:board_col0_empty) { described_class.new }

      it 'returns nil' do
        expect(board_col0_empty.last_occupied_position(0)).to be_nil
      end
    end
  end

  describe '#column_available?' do
    subject(:board_0full1empty) { described_class.new }

    before do
      6.times { board_0full1empty.drop_in_column(0, 'X') }
    end

    it 'returns true if given column has any spot available' do
      col_full_index = 0
      expect(board_0full1empty.column_available?(col_full_index)).to eq(true)
    end

    it 'returns false if given column has no spot available' do
      col_empty_index = 1
      expect(board_0full1empty.column_available?(col_empty_index)).to eq(false)
    end
  end

  describe '#full?' do
    context 'when board is full' do
      subject(:board_full) { described_class.new }

      before do
        (0..6).each do |col_i|
          6.times { board_full.drop_in_column(col_i, 'X') }
        end
      end

      it 'returns true' do
        expect(board_full.full?).to eq(true)
      end
    end

    context 'when board is not completely full' do
      subject(:board_not_full) { described_class.new }
      before { board_not_full.drop_in_column(0, 'X') }

      it 'returns false if board is not completely full' do
        expect(board_not_full.full?).to eq(false)
      end
    end

    context 'when board is empty' do
      subject(:board_empty) { described_class.new }

      it 'returns false if board is empty' do
        expect(board_empty.full?).to eq(false)
      end
    end
  end

  describe '#four_in_column?' do
    context 'when there are four equal marks in a column' do
      subject(:board_four_equal_in_column0) { described_class.new }

      before do
        4.times { board_four_equal_in_column0.drop_in_column(0, 'X') }
      end

      it 'returns true' do
        col_index = 0
        symbol = 'X'
        expect(board_four_equal_in_column0.four_in_column?(col_index, symbol)).to eq(true)
      end
    end

    context 'When there are four marks in a column that are not equal' do
      subject(:board_four_different_in_column0) { described_class.new }

      before do
        2.times { board_four_different_in_column0.drop_in_column(0, 'X') }
        2.times { board_four_different_in_column0.drop_in_column(0, 'O') }
      end

      it 'returns false' do
        col_index = 0
        symbol = 'X'
        expect(board_four_different_in_column0.four_in_column?(col_index, symbol)).to eq(false)
      end
    end
  end

  describe '#four_in_line?' do
    context 'when there are four equal marks in a line' do
      subject(:board_four_equal_in_line0) { described_class.new }

      before do
        board_four_equal_in_line0.drop_in_column(0, 'X')
        board_four_equal_in_line0.drop_in_column(1, 'X')
        board_four_equal_in_line0.drop_in_column(2, 'X')
        board_four_equal_in_line0.drop_in_column(3, 'X')
      end

      it 'returns true' do
        line_index = 0
        symbol = 'X'
        expect(board_four_equal_in_line0.four_in_line?(line_index, symbol)).to eq(true)
      end
    end

    context 'when there are four marks in a line that are not equal' do
      subject(:board_four_different_in_line0) { described_class.new }

      before do
        board_four_different_in_line0.drop_in_column(0, 'X')
        board_four_different_in_line0.drop_in_column(1, 'X')
        board_four_different_in_line0.drop_in_column(2, 'O')
        board_four_different_in_line0.drop_in_column(3, 'O')
      end

      it 'returns false' do
        line_index = 0
        symbol = 'X'
        expect(board_four_different_in_line0.four_in_line?(line_index, symbol)).to eq(false)
      end
    end
  end

  describe '#four_in_cross?' do
    context 'when there are four equal marks in the main cross' do
      subject(:board_four_equal_in_cross) { described_class.new }

      before do
        board_four_equal_in_cross.drop_in_column(0, 'X')

        board_four_equal_in_cross.drop_in_column(1, 'O')
        board_four_equal_in_cross.drop_in_column(1, 'X')

        board_four_equal_in_cross.drop_in_column(2, 'O')
        board_four_equal_in_cross.drop_in_column(2, 'O')
        board_four_equal_in_cross.drop_in_column(2, 'X')

        board_four_equal_in_cross.drop_in_column(3, 'O')
        board_four_equal_in_cross.drop_in_column(3, 'O')
        board_four_equal_in_cross.drop_in_column(3, 'O')
        board_four_equal_in_cross.drop_in_column(3, 'X')
      end

      it 'returns true' do
        col_index = 3
        line_index = 3
        symbol = 'X'
        expect(board_four_equal_in_cross.four_in_cross?(col_index, line_index, symbol)).to eq(true)
      end
    end

    context 'when there are four equal marks in the anti cross' do
      subject(:board_four_equal_in_cross) { described_class.new }

      before do
        board_four_equal_in_cross.drop_in_column(0, 'O')
        board_four_equal_in_cross.drop_in_column(0, 'O')
        board_four_equal_in_cross.drop_in_column(0, 'O')
        board_four_equal_in_cross.drop_in_column(0, 'X')

        board_four_equal_in_cross.drop_in_column(1, 'O')
        board_four_equal_in_cross.drop_in_column(1, 'O')
        board_four_equal_in_cross.drop_in_column(1, 'X')

        board_four_equal_in_cross.drop_in_column(2, 'O')
        board_four_equal_in_cross.drop_in_column(2, 'X')

        board_four_equal_in_cross.drop_in_column(3, 'X')
      end

      it 'returns true' do
        col_index = 3
        line_index = 0
        symbol = 'X'
        expect(board_four_equal_in_cross.four_in_cross?(col_index, line_index, symbol)).to eq(true)
      end
    end

    context 'when there are four marks in the main cross that are not equal' do
      subject(:board_four_different_in_cross) { described_class.new }

      before do
        board_four_different_in_cross.drop_in_column(0, 'X')

        board_four_different_in_cross.drop_in_column(1, 'O')
        board_four_different_in_cross.drop_in_column(1, 'X')

        board_four_different_in_cross.drop_in_column(2, 'O')
        board_four_different_in_cross.drop_in_column(2, 'O')
        board_four_different_in_cross.drop_in_column(2, 'O')

        board_four_different_in_cross.drop_in_column(3, 'O')
        board_four_different_in_cross.drop_in_column(3, 'O')
        board_four_different_in_cross.drop_in_column(3, 'O')
        board_four_different_in_cross.drop_in_column(3, 'O')
      end

      it 'returns false' do
        col_index = 3
        line_index = 3
        symbol = 'X'
        expect(board_four_different_in_cross.four_in_cross?(col_index, line_index, symbol)).to eq(false)
      end
    end

    context 'when there are four marks in the anti cross that are not equal' do
      subject(:board_four_different_in_cross) { described_class.new }

      before do
        board_four_different_in_cross.drop_in_column(0, 'O')
        board_four_different_in_cross.drop_in_column(0, 'O')
        board_four_different_in_cross.drop_in_column(0, 'O')
        board_four_different_in_cross.drop_in_column(0, 'O')

        board_four_different_in_cross.drop_in_column(1, 'O')
        board_four_different_in_cross.drop_in_column(1, 'O')
        board_four_different_in_cross.drop_in_column(1, 'O')

        board_four_different_in_cross.drop_in_column(2, 'O')
        board_four_different_in_cross.drop_in_column(2, 'X')

        board_four_different_in_cross.drop_in_column(3, 'X')
      end

      it 'returns false' do
        col_index = 3
        line_index = 0
        symbol = 'X'
        expect(board_four_different_in_cross.four_in_cross?(col_index, line_index, symbol)).to eq(false)
      end
    end

    context 'when cross has less than four slots' do
      subject(:board_invalid_cross) { described_class.new }

      before do
        board_invalid_cross.drop_in_column(6, 'O')
        board_invalid_cross.drop_in_column(6, 'O')
        board_invalid_cross.drop_in_column(6, 'X')

        board_invalid_cross.drop_in_column(5, 'O')
        board_invalid_cross.drop_in_column(5, 'X')

        board_invalid_cross.drop_in_column(4, 'X')
      end

      it 'returns false' do
        col_index = 4
        line_index = 0
        symbol = 'X'
        expect(board_invalid_cross.four_in_cross?(col_index, line_index, symbol)).to eq(false)
      end
    end
  end
end

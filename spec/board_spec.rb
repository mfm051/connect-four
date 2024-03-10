# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board_empty) { described_class.new }

  describe '#drop_in_column' do
    it 'marks first element available in column' do
      symbol_dropped = 'X'
      column_first = board_empty.instance_variable_get(:@columns)[0]
      expect { board_empty.drop_in_column(0, symbol_dropped) }.to change { column_first[0] }.to symbol_dropped
    end

    context 'when there is already a marked position' do
      subject(:board_one_pos) { described_class.new }
      before { board_one_pos.drop_in_column(0, 'X') }

      let(:column_first) { board_one_pos.instance_variable_get(:@columns)[0] }

      it 'marks next available element' do
        symbol_dropped = 'O'
        expect { board_one_pos.drop_in_column(0, symbol_dropped) }.to change { column_first[1] }.to symbol_dropped
      end

      it 'does not change previous elements' do
        symbol_dropped = 'O'
        expect { board_one_pos.drop_in_column(0, symbol_dropped) }.not_to(change { column_first[0] })
      end
    end

    context 'when column is full' do
      subject(:board_full_col) { described_class.new }
      let(:column_full) { board_full_col.instance_variable_get(:@columns)[0] }

      before do
        6.times { board_full_col.drop_in_column(0, 'X') }
      end

      it 'does not change column' do
        different_symbol = 'O'
        expect { board_full_col.drop_in_column(0, different_symbol) }.not_to(change { column_full })
      end
    end
  end
end

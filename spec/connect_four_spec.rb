# frozen_string_literal: true

require_relative '../lib/connect_four'

describe ConnectFour do
  subject(:connect_four) { described_class.new }

  describe '#pick_column' do
    let(:board) { connect_four.instance_variable_get(:@board) }
    let(:current_player) { connect_four.instance_variable_get(:@current_player) }

    it 'sends message to mark board' do
      col_to_drop = 0
      expect(board).to receive(:drop_in_column).with(col_to_drop, current_player)
      connect_four.pick_column(col_to_drop)
    end
  end
end

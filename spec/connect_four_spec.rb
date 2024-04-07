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

  describe '#game_over?' do
    let(:board) { connect_four.instance_variable_get(:@board) }
    let(:current_player) { connect_four.instance_variable_get(:@current_player) }
    let(:col_to_pick) { 0 }

    before { connect_four.pick_column(col_to_pick) }

    it 'sends message to test if current move completes four in any direction' do
      expect(board).to receive(:four_complete?).with(col_to_pick, current_player)
      connect_four.game_over?(col_to_pick)
    end
  end
end

# frozen_string_literal: true

require_relative '../lib/connect_four'

describe ConnectFour do
  subject(:connect_four) { described_class.new }

  describe '#pick_column' do
    let(:board) { connect_four.instance_variable_get(:@board) }
    let(:current_player) { connect_four.instance_variable_get(:@current_player) }

    before do
      allow(connect_four).to receive(:gets).and_return '0'
    end

    it 'sends message to mark board' do
      expect(board).to receive(:drop_in_column)
      connect_four.pick_column
    end

    it 'changes current_column' do
      expect { connect_four.pick_column }.to change { connect_four.instance_variable_get(:@current_column) }.to 0
    end
  end

  describe '#game_over?' do
    let(:board) { connect_four.instance_variable_get(:@board) }
    let(:current_player) { connect_four.instance_variable_get(:@current_player) }

    before do
      allow(connect_four).to receive(:gets).and_return '0'
      connect_four.pick_column
    end

    it 'sends message to test if current move completes four in any direction' do
      current_column = connect_four.instance_variable_get(:@current_column)
      expect(board).to receive(:four_complete?).with(current_column, current_player)
      connect_four.game_over?
    end
  end

  describe '#rotate_player' do
    subject(:game_oneX_twoO) { described_class.new('X', 'O') }

    it 'changes current player' do
      expect { game_oneX_twoO.rotate_player }.to change {
                                                   game_oneX_twoO.instance_variable_get(:@current_player)
                                                 }.from('X').to 'O'
    end
  end
end

# frozen_string_literal: true

# ConnectFour board
class Board
  def initialize
    @columns = Array.new(7) { Array.new(6) }
  end

  def drop_in_column(column_index, symbol)
    column_to_drop = @columns[column_index]

    column_to_drop.each_with_index do |element, i|
      next unless element.nil?

      return column_to_drop[i] = symbol
    end
  end

  def column_available?(col_index) = @columns[col_index].any?

  def full? = @columns.all?(&:all?)
end
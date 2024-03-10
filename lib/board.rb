# frozen_string_literal: true

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
end

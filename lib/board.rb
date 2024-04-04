# frozen_string_literal: true

# ConnectFour board
class Board
  def initialize
    @columns = Array.new(7) { Array.new(6) }
  end

  def drop_in_column(col_index, symbol)
    column_to_drop = @columns[col_index]

    column_to_drop.each_with_index do |element, i|
      next unless element.nil?

      return column_to_drop[i] = symbol
    end
  end

  def last_occupied_position(col_index)
    column_occupied = @columns[col_index].compact

    column_occupied.empty? ? nil : column_occupied.length - 1
  end

  def column_available?(col_index) = @columns[col_index].any?

  def full? = @columns.all?(&:all?)

  def four_in_column?(col_index, symbol)
    column = @columns[col_index]

    groups_of_four = [column[0..3], column[1..4], column[2..5]]

    groups_of_four.any? { |group| group.all?(symbol) }
  end

  def four_in_line?(line_index, symbol)
    line = lines[line_index]

    groups_of_four = [line[0..3], line[1..4], line[2..5]]

    groups_of_four.any? { |group| group.all?(symbol) }
  end

  def four_in_cross?(col_index, line_index, symbol)
    crosses = [main_cross(col_index, line_index), anti_cross(col_index, line_index)]

    crosses.each do |cross|
      next if cross.length < 4

      groups_of_four = [cross[0..3], cross[1..4], cross[2..5]]

      return true if groups_of_four.any? { |group| group.all?(symbol) }
    end

    false
  end

  def to_s
    puts "0 1 2 3 4 5 6\n"
    lines.reverse.each do |line| # Lines in reverse so that the first is at the bottom
      line_marks = line.map { |mark| mark.nil? ? '⚬' : mark }

      puts "#{line_marks.join(' ')}\n"
    end
  end

  private

  def lines = @columns.transpose

  def main_cross(col_index, line_index)
    cross = []

    upper_lines = lines[line_index..]
    lower_lines = lines - upper_lines

    upper_lines.each_with_index { |line, i| cross << line[col_index + i] }

    lower_lines.reverse.each_with_index { |line, i| cross.prepend(line[col_index - i - 1]) }

    cross
  end

  def anti_cross(col_index, line_index)
    cross = []

    upper_lines = lines[line_index..]
    lower_lines = lines - upper_lines

    upper_lines.each_with_index { |line, i| cross.prepend(line[col_index - i]) }

    lower_lines.reverse.each_with_index { |line, i| cross << line[col_index + i + 1] }

    cross
  end
end

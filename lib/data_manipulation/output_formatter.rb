require 'terminal-table'

class OutputFormatter
  def initialize(players_array)
    @players_array = players_array || []
  end

  def call
    print_header
    print_rows
  end

  private

  attr_reader :players_array

  def print_header
    puts table_border
    puts "| playerID | yearID   | Team Name(s) #{' ' * 75} | Batting Average |"
    puts table_border
  end

  def table_border
    "+#{('-' * 11)}+#{('-' * 9)}+#{('-' * 90)}+#{('-' * 17)}+"
  end

  def print_rows
    players_array.each do |player|
      puts "#{formatted_row(player[:playerID], 10)}#{formatted_row(player[:yearID], 8)}#{formatted_row(player[:teamID], 89)}#{formatted_row(player[:ba].to_s, 16)}|"
    end
    puts table_border
  end

  def formatted_row(str, length)
    str = str.length > length ? (str[0..length - 4] + '...') : str
    "| #{str}#{' ' * (length - str.length)}"
  end
end

require_relative 'csv_processing/csv_processor'
require_relative 'data_manipulation/output_formatter'
require_relative 'data_manipulation/players_sorter'
require_relative 'data_manipulation/batting_average_adder'

class RankingsCounter
  def initialize(csv_filename, **filters)
    @csv_string = File.read(csv_filename)
    @filters = filters.delete_if { |k, v| v.empty? }
  end

  def call
    sorted_players_array = sort_players(players_stats_with_batting_average)
    OutputFormatter.new(sorted_players_array).call
  end

  private

  attr_reader :csv_string, :filters

  def processed_players_data_hash
    @processed_players_data_hash ||= CsvProcessor.new(csv_string, filters).call
  end

  def players_stats_with_batting_average
    BattingAverageAdder.new(processed_players_data_hash).call
  end

  def sort_players(players_hash)
    PlayersSorter.new(players_hash).call
  end
end

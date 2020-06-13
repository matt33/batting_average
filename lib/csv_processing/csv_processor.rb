require 'csv'
require_relative 'row_processor'
require_relative '../filters/filters_factory'
require_relative '../teams/teams_convertor'

class CsvProcessor
  REQUIRED_FIELDS = [:playerID, :yearID, :teamID, :H, :AB]

  def initialize(csv_string, filters)
    @csv_string = csv_string
    @filters = FiltersFactory.new(filters).create_filters
  end

  def call
    processed_players = {}
    CSV.parse(csv_string, headers: true, header_converters: ->(header){ header.to_sym }).map do |csv_row|
      csv_row[:teamID] = team_lookup_table[csv_row[:teamID]]
      next if filters.map{ |f| f.filtered_out?(csv_row) }.any? || invalid_row?(csv_row)
      processed_players[row_key(csv_row)] = row_processor(processed_players[row_key(csv_row)], csv_row).call
    end
    processed_players
  end

  private

  attr_reader :csv_string, :filters

  def row_key(csv_row)
    "#{csv_row[:playerID]}$#{csv_row[:yearID]}"
  end

  def row_processor(processed_players_row, csv_row)
    RowProcessor.new(processed_players_row, csv_row)
  end

  def team_lookup_table
    @team_lookup_table ||= TeamsConvertor.team_lookup_table
  end

  def invalid_row?(csv_row)
    csv_row.values_at(*REQUIRED_FIELDS).any?(&:nil?)
  end
end

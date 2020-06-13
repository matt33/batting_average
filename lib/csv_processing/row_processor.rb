class RowProcessor
  def initialize(processed_players_row, csv_row)
    @processed_players_row = processed_players_row
    @csv_row = csv_row
  end

  def call
    return combine_rows if processed_players_row
    initialize_row
  end

  private

  def combine_rows
    processed_players_row[:AB] += csv_row[:AB].to_i
    processed_players_row[:H] += csv_row[:H].to_i
    processed_players_row[:teamID] += ", #{csv_row[:teamID]}"
    processed_players_row
  end

  def initialize_row
    {
      playerID: csv_row[:playerID],
      yearID: csv_row[:yearID],
      teamID: csv_row[:teamID],
      AB: csv_row[:AB].to_i,
      H: csv_row[:H].to_i
    }
  end

  attr_reader :csv_row, :processed_players_row
end

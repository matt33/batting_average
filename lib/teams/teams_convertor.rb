require 'csv'

TEAMS_FILENAME = 'teams.csv'

class TeamsConvertor
  def self.team_lookup_table
    team_lookup_table = {}
    CSV.parse(File.read(TEAMS_FILENAME), headers: true, header_converters: ->(header){ header.to_sym }).map do |csv_row|
      team_lookup_table[csv_row[:teamID]] = csv_row[:name]
    end
    team_lookup_table
  end
end

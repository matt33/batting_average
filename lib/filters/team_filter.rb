class TeamFilter
  def initialize(team)
    @team = team
  end

  def filtered_out?(row)
    !row[:teamID].include?(team)
  end

  private

  attr_reader :team
end

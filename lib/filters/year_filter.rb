class YearFilter
  def initialize(year)
    @year = year
  end

  def filtered_out?(row)
    row[:yearID] != year
  end

  private

  attr_reader :year
end

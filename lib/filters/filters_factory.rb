require_relative 'year_filter'
require_relative 'team_filter'

VALID_FILTER_NAMES = ['year', 'team']

class FiltersFactory
  def initialize(filters)
    @filter_names = filters.keys.map(&:to_s)
    @filter_values = filters.values
  end

  def create_filters
    ensure_valid_filter_names
    filter_names.map.each_with_index do |name, index|
      initialize_filter(name, filter_values[index])
    end
  end

  private

  attr_reader :filter_names, :filter_values

  def initialize_filter(name, filter_value)
    Object.const_get("#{name.capitalize}Filter").new(filter_value)
  end

  def ensure_valid_filter_names
    raise "Invalid filters detected: #{invalid_filter_names.join("\n")}\n
      Allowed filter names: #{VALID_FILTER_NAMES}" if invalid_filter_names.any?
  end

  def invalid_filter_names
    filter_names - VALID_FILTER_NAMES
  end
end

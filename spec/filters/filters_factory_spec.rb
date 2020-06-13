require_relative '../../lib/filters/filters_factory'

describe FiltersFactory do
  subject { described_class.new(filters) }

  context 'when filters have invalid names' do
    let(:filters) do
      { name: 'Steve', h: '2' }
    end

    it 'raises an error' do
      expect { subject.create_filters }.to raise_error
    end
  end

  context 'when filters are valid' do
    let(:filters) do
      { year: 2019, team: 'San Antonio' }
    end

    it 'creates 2 filter instances' do
      expect(subject.create_filters.map(&:class)).to match_array([YearFilter, TeamFilter])
    end
  end
end

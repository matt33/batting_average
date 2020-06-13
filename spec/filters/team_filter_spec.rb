require_relative '../../lib/filters/team_filter'

describe TeamFilter do
  let(:team) { 'San Antonio' }
  let(:filtered_out_row) do
    { :playerID=>"espinpa01", :yearID=>"2017", :teamID=>"Milwaukee Brewers", :AB=>'4', :H=>'1' }
  end
  let(:not_filtered_row) do
    { :playerID=>"espinpa01", :yearID=>"2017", :teamID=>"San Antonio", :AB=>'4', :H=>'1' }
  end
  subject { described_class.new(team) }

  it 'filters out correct rows' do
    expect(subject.filtered_out?(filtered_out_row)).to be_truthy
    expect(subject.filtered_out?(not_filtered_row)).to be_falsey
  end
end

require_relative '../../lib/csv_processing/row_processor'

describe RowProcessor do
  let(:csv_row) {
    { :playerID=>"espinpa01", :yearID=>"2017", :teamID=>"Milwaukee Brewers", :AB=>'4', :H=>'1' }
  }

  subject { described_class.new(processed_players_row, csv_row) }

  context 'when given an empty existing row' do
    let(:processed_players_row) {}

    it 'initializes a row' do
      row = subject.call
      expect(row).to eq({ :playerID=>"espinpa01", :yearID=>"2017", :teamID=>"Milwaukee Brewers", :AB=>4, :H=>1 } )
    end
  end

  context 'combines two rows' do
    let(:processed_players_row) do
      { :playerID=>"espinpa01", :yearID=>"2017", :teamID=>"San Antonio", :AB=>9, :H=>7 }
    end

    it 'initializes a row' do
      row = subject.call
      expect(row).to eq({ :playerID=>"espinpa01", :yearID=>"2017", :teamID=>"San Antonio, Milwaukee Brewers",
        :AB=>13, :H=>8 } )
    end
  end
end

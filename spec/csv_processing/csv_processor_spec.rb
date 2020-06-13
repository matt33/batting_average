require_relative '../../lib/csv_processing/csv_processor'

describe CsvProcessor do
  let(:csv_string) do
    'playerID,yearID,stint,teamID,lgID,G,AB,R,H,2B,3B,HR,RBI,SB,CS,BB,SO,IBB,HBP,SH,SF,GIDP
espinda01,2017,1,LAA,AL,77,228,27,37,8,0,6,29,3,5,19,91,1,4,1,2,2
espinda01,2017,2,SEA,AL,8,16,2,3,2,0,0,2,1,0,1,7,0,0,0,0,0
espinda01,2017,3,TBA,AL,8,22,1,6,0,0,0,0,0,0,1,11,0,1,0,0,0
espinpa01,2017,1,MIL,NL,6,4,0,1,0,0,0,0,0,0,0,1,0,0,1,0,0
espinpa01,2017,2,TEX,AL,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
estevca01,2018,1,COL,NL,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
estrama01,2019,1,SEA,AL,33,4,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0'
  end

  subject { described_class.new(csv_string, filters) }

  context 'when processing without filters' do
    let(:filters) { {} }

    it 'processes CSV string into desired hash for all years and teams' do
      players_hash = subject.call
      expect(players_hash.keys).to match_array(['espinda01$2017', 'espinpa01$2017', 'estevca01$2018', 'estrama01$2019'])
      expect(players_hash['espinda01$2017']).to eq({:playerID => 'espinda01', :yearID => '2017',
        :teamID => 'Los Angeles Angels of Anaheim, Seattle Mariners, Tampa Bay Rays', :AB => 266, :H => 46})
      expect(players_hash['espinpa01$2017']).to eq({:playerID=>'espinpa01', :yearID=>'2017',
        :teamID=>'Milwaukee Brewers, Texas Rangers', :AB=>4, :H=>1})
      expect(players_hash['estevca01$2018']).to eq({:playerID=>'estevca01', :yearID=>'2018',
        :teamID=>'Colorado Rockies', :AB=>0, :H=>0})
      expect(players_hash['estrama01$2019']).to eq({:playerID=>'estrama01', :yearID=>'2019',
        :teamID=>'Seattle Mariners', :AB=>4, :H=>0})
    end
  end

  context 'when processing with year filter' do
    let(:filters) { { year: '2018' } }

    it 'processes CSV string into hash for 2018 year only' do
      players_hash = subject.call
      expect(players_hash.keys).to eq(['estevca01$2018'])
    end
  end

  context 'when processing with team filter' do
    let(:filters) { { team: 'Seattle Mariners' } }

    it 'processes CSV string into hash for Seattle Mariners team only' do
      players_hash = subject.call
      expect(players_hash.keys).to match_array(['espinda01$2017', 'estrama01$2019'])
    end
  end

  context 'when processing with team and year filter' do
    let(:filters) { { team: 'Seattle Mariners', year: '2019' } }

    it 'processes CSV string into hash for Seattle Mariners team only' do
      players_hash = subject.call
      expect(players_hash.keys).to eq(['estrama01$2019'])
    end
  end
end

require_relative '../../lib/data_manipulation/batting_average_adder'

describe BattingAverageAdder do
  let(:players_hash) do
   {
      "espinda01$2017"=>{:playerID=>"espinda01", :yearID=>"2017", :teamID=>"Los Angeles Angels of Anaheim, Seattle Mariners, Tampa Bay Rays", :AB=>266, :H=>46},
      "espinpa01$2017"=>{:playerID=>"espinpa01", :yearID=>"2017", :teamID=>"Milwaukee Brewers, Texas Rangers", :AB=>4, :H=>1},
      "estevca01$2018"=>{:playerID=>"estevca01", :yearID=>"2018", :teamID=>"Colorado Rockies", :AB=>0, :H=>0},
      "estrama01$2019"=>{:playerID=>"estrama01", :yearID=>"2019", :teamID=>"Seattle Mariners", :AB=>4, :H=>2}
    }
  end
  subject { described_class.new(players_hash) }

  it 'injects batting average into players hash' do
    enhanced_hash = subject.call
    expect(enhanced_hash["espinda01$2017"][:ba]).to eq(0.173)
    expect(enhanced_hash["espinpa01$2017"][:ba]).to eq(0.25)
    expect(enhanced_hash["estevca01$2018"][:ba]).to eq(0)
    expect(enhanced_hash["estrama01$2019"][:ba]).to eq(0.5)
  end
end

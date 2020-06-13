require_relative '../../lib/data_manipulation/players_sorter'

describe PlayersSorter do
  let(:players_hash) do
   {
     "espinda01$2017"=>{:playerID=>"espinda01", :yearID=>"2017", :teamID=>"Los Angeles Angels of Anaheim, Seattle Mariners, Tampa Bay Rays", :AB=>266, :H=>46, :ba=>0.173},
     "espinpa01$2017"=>{:playerID=>"espinpa01", :yearID=>"2017", :teamID=>"Milwaukee Brewers, Texas Rangers", :AB=>4, :H=>1, :ba=>0.25},
     "estevca01$2018"=>{:playerID=>"estevca01", :yearID=>"2018", :teamID=>"Colorado Rockies", :AB=>0, :H=>0, :ba=>0},
     "estrama01$2019"=>{:playerID=>"estrama01", :yearID=>"2019", :teamID=>"Seattle Mariners", :AB=>4, :H=>2, :ba=>0.5}
    }
  end
  subject { described_class.new(players_hash) }

  it 'sorts players hash by :ba (batting average) into an array and removes unique key' do
    sorted_array = subject.call
    expect(sorted_array.map{|player| player[:playerID]}).to eq(["estrama01", "espinpa01", "espinda01", "estevca01"])
  end
end

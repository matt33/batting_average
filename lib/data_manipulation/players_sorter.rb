class PlayersSorter
  def initialize(players_hash)
    @players_hash = players_hash
  end

  def call
    players_hash.sort_by { |k,v| -v[:ba]  }.transpose[1]
  end

  private

  attr_reader :players_hash
end

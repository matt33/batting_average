class BattingAverageAdder
  def initialize(players_hash)
    @players_hash = players_hash
  end

  def call
    players_hash.each do |key, player|
      players_hash[key] = player.merge(batting_average_for(player))
    end
    players_hash
  end

  private

  attr_reader :players_hash

  def batting_average_for(player)
    return { ba: 0.0 } if player[:AB].to_f == 0
    { ba: (player[:H].to_f / player[:AB].to_f).round(3) }
  end
end

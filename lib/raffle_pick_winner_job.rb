class RafflePickWinnerJob < Struct.new(:id)
  def perform
    raffle = Raffle.find(id)
    raffle.pick_winner!
  end
end

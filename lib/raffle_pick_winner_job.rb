class RafflePickWinnerJob < Struct.new(:id)
  def perform
    raffle = Raffle.find(id)
  end
end

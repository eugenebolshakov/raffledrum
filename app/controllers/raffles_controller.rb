class RafflesController < ApplicationController
  def index
    @raffles = Raffle.active.paginate(:page => params[:page])
  end
end

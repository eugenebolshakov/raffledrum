class MyRafflesController < ApplicationController
  before_filter :login_required

  def new
    @raffle = Raffle.new
  end
end

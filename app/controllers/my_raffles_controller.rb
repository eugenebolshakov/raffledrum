class MyRafflesController < ApplicationController
  before_filter :login_required

  def new
    @raffle = Raffle.new
  end

  def create
    @raffle = current_user.raffles.new(params[:raffle])
    if @raffle.save
      flash[:notice] = 'Raffle has been created'
      redirect_to my_raffles_path
    else
      render :action => :new
    end
  end

  def index
    @raffles = current_user.raffles.active + current_user.raffles.inactive
  end

  def show
    @raffle = Raffle.find(params[:id])
  end
end

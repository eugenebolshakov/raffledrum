class MyRafflesController < ApplicationController
  before_filter :login_required
  before_filter :find_raffle, :only => %w(show change_winner)

  def new
    @raffle = Raffle.new
  end

  def create
    @raffle = current_user.raffles.new(params[:raffle])
    if @raffle.save
      Delayed::Job.enqueue(RaffleTweetJob.new(@raffle.id), 2)
      Delayed::Job.enqueue(RaffleUpdateJob.new(@raffle.id), 1, 10.seconds.from_now)
      Delayed::Job.enqueue(RafflePickWinnerJob.new(@raffle.id), 0, @raffle.end_time)
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
    @participants = @raffle.participants.paginate(:page => params[:page])
  end

  def change_winner
    @raffle.pick_winner!
    flash[:notice] = 'Another winner has been selected'
    redirect_to my_raffle_path(@raffle)
  end

  private

    def find_raffle
      @raffle = Raffle.find(params[:id])
    end
end

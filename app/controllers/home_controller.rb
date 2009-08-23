class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to current_user.raffles.count.zero? ?
        new_my_raffle_path : 
        my_raffles_path
    else
      @randon_raffle = Raffle.active.find(:first, :order => 'rand()')
    end
  end
end

class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to current_user.raffles.count.zero? ?
        new_my_raffle_path : 
        my_raffles_path
    end
  end
end

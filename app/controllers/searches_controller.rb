class SearchesController < ApplicationController
  before_action :logged_in_user, only: [:search]

  def search
    @range = params[:range]

    if @range == "User"
      @users = Kaminari.paginate_array(User.looks(params[:word])).page(params[:page]).per(10)
    else
      @microposts = Kaminari.paginate_array(Micropost.looks(params[:word])).page(params[:page]).per(6)
    end
  end
end

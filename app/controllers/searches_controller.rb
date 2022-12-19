class SearchesController < ApplicationController
  before_action :logged_in_user, only: [:search]

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @microposts = Kaminari.paginate_array(Micropost.looks(params[:search], params[:word])).page(params[:page]).per(6)
    end
  end
end

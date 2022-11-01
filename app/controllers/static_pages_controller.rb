class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @feed_items = Micropost.paginate(page: params[:page], per_page: 6)
    end
  end
end

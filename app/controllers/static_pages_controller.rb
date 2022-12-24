class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @feed_items = Micropost.where(user_id: [current_user.id, *current_user.following_ids]).paginate(page: params[:page], per_page: 6)
    end
  end
end

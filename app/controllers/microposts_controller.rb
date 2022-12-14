class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def new
    @micropost = Micropost.new
  end
  
  def create
    puts micropost_params
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.images.attach(params[:micropost][:images])
    
    tags_list = params[:micropost][:tags].split(nil)

    if @micropost.save
      @micropost.save_tag(tags_list)
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else  
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 6)
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to root_url
  end
  
  def show
    @micropost = Micropost.find_by(id: params[:id])
    @user = User.find_by(id: @micropost.user_id)
    tags_list = @micropost.tags.pluck(:name)
    @tags = ""
    tags_list.each do |tag|
      @tags += "##{tag}, "
    end
    @tags = @tags[..-3]
  end
  
  private

    def micropost_params
      params.require(:micropost).permit(:content, :images, :lat, :lng, :address)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end

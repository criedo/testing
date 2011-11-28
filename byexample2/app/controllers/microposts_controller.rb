# app/controllers/microposts_controller.rb crfr110911
class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  def index
    @title = "User microposts"
    @user = User.find(params[:user_id])
    @micropost = @user.microposts.find_by_id(params[:user_id])
    @feed_items = @user.feed.paginate(:page => params[:page], :per_page => 20)
  end
  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @user_img = true
      @feed_items = []
      render 'pages/home'
    end
  end
  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end
  def index
    @title = "User microposts"
    @user = User.find(params[:user_id])
    @micropost = @user.microposts.find_by_id(params[:user_id])
    @feed_items = @user.feed.paginate(:page => params[:page], :per_page => 20)
  end
  private
  def authorized_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_path if @micropost.nil?
  end
end

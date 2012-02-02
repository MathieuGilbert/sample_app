class UsersController < ApplicationController
  before_filter :authenticate,   :only => [:edit, :update, :index, :destroy]
  before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user,     :only => [:destroy]
  before_filter :logged_in_user, :only => [:new, :create]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the sample app!"
      redirect_to @user
    else
      @user.update_attributes(:password => "", :password_confirmation => "")
      render :new
    end
  end
  
  def edit

  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render :edit
    end
  end
  
  def index
    @users = User.paginate(:page => params[:page],
                           :per_page => 10)
  end
  
  def destroy
    user = User.find(params[:id])
    
    if current_user == user
      flash[:error] = "You can't delete yourself!"
    else
      user.destroy
      flash[:success] = "User destroyed."
    end
    
    redirect_to users_path
  end
  
  private
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    def logged_in_user
      redirect_to(root_path) if signed_in?
    end
end

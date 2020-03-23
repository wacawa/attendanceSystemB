class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :correct_user]
  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :admin_user, only: [:index]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def show
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "作成に成功しました。"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "アカウントを更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
    end

  # before_action
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def logged_in_user
    if current_user.nil?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
  def correct_user
    redirect_to root_url if !current_user?(@user) 
  end

  def admin_user
    flash[:danger] = "アクセス権限がありません。"
    redirect_to root_url unless current_user.admin?
  end

end

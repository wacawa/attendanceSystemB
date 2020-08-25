class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :correct_user]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :admin_user, only: [:index, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @sum_worked = @user.attendances.where.not(started_at: nil).count
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
  
  def edit_basic_info
    @user = @current_user
  end
  
  def update_basic_info
    @user = @current_user
    if @user.update_attributes(basic_info_paramas)
      User.update_all [ 'basic_time = ?', @user.basic_time]
      User.update_all [ 'work_time = ?', @user.work_time]
      flash[:success] = "基本情報を更新しました。"
      redirect_to users_url
    else
      flash[:danger] = "更新に失敗しました。"
      render :edit_basic_info
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
    end
    
    def basic_info_paramas
      params.require(:user).permit(:basic_time, :work_time)
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
    redirect_to root_url if !current_user?(@user) && !current_user.admin?
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = "アクセス権限がありません。" 
      redirect_to root_url 
    end
  end

end

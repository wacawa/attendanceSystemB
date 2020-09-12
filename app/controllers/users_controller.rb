class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :correct_user]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :admin_user, only: [:index, :destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show
  
  def index
    if params[:search].nil?
      @users = User.paginate(page: params[:page], per_page: 10)
      @h1 = "ユーザー一覧"
      @placeholder = "キーワードを入力..."
    else
      @users = User.paginate(page: params[:page], per_page: 10).search(params[:search])
      @h1 = "検索結果"
      @placeholder = params[:search]
    end
  end
  
  def show
    @sum_worked = @attendances.where.not(started_at: nil, finished_at: nil).count
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
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
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
  
end

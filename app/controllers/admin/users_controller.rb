class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :set_group, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @users = User.all
  end  
  
  def mypage
    @user = current_user || current_teacher
  end

  def new
    @user = User.new
  end

  def create
    @user = @group.users.new(user_params)
    if @user.save
      @group.users << @user
      redirect_to group_admin_users_path(@group), notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to group_admin_users_path(@group), noice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to group_admin_users_path(@group), notice: "ユーザー「#{@user.name}」を削除しました。"
  end



  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

end

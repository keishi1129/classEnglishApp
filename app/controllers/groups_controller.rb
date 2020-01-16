class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]
  
  def index
    redirect_to new_group_path unless current_teacher.groups.present?
    @groups = current_teacher.groups
  end

  def before_user_create
    redirect_to new_group_path unless current_teacher.groups.present?
    @groups = current_teacher.groups
  end
  
  def before_user_list
    redirect_to new_group_path unless current_teacher.groups.present?
    @groups = current_teacher.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.teachers << current_teacher
    if @group.save
      redirect_to groups_path(@group), notice: 'グループを作成しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to group_messages_path(@group), notice: 'グループを編集しました'
    else
      render :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, { :user_ids => []})
  end

  def set_group
    @group = Group.find(params[:id])
  end
end


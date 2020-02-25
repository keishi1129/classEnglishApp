class ChatroomsController < ApplicationController

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      redirect_to chatroom_messages_path(@chatroom)
      # respond_to do |format|
      #   format.html
      #   format.json
      # end
    else
      # format.json 
    end
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:name).merge(classroom_id: current_student.classroom.id)
  end
end

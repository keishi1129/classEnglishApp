class MessagesController < ApplicationController
  before_action :set_chatroom

  def index
   @message = Message.new
   @messages = @chatroom.messages.includes(:student)
  end

  def create
    @message = @chatroom.messages.new(message_params)
    respond_to do |format|
      if @message.save
        format.html { redirect_to chatroom_messages_path(@chatroom), notice: 'メッセージが送信されました'}
        format.json
      else
        @messages = @chatroom.messages.includes(:student)
        format.html { 
          flash.now[:alert] = 'メッセージを入力してください' 
          render :index
        }
        format.json
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(student_id: current_student.id)
  end

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end
end

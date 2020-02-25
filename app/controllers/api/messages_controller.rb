class Api::MessagesController < ApplicationController
  def index
        # ルーティングでの設定によりparamsの中にgroup_idというキーでグループのidが入るので、これを元にDBからグループを取得する
        chatroom = Chatroom.find(params[:chatroom_id])
        # ajaxで送られてくる最後のメッセージのid番号を変数に代入
        last_message_id = params[:id].to_i
        # 取得したグループでのメッセージ達から、idがlast_message_idよりも新しい(大きい)メッセージ達のみを取得
        @messages = chatroom.messages.includes(:student).where("id > #{last_message_id}")
  end
end
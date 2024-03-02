class ChatsController < ApplicationController
  def index
    @chats = Chat.all
  end

  def new
    @chat = Chat.create!
    redirect_to chat_messages_path(@chat)
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    redirect_to chats_path
  end
end

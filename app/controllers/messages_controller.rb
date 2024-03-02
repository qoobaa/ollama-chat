class MessagesController < ApplicationController
  before_action :fetch_chat

  def index
    @messages = @chat.messages.all.order(created_at: :asc)
  end

  def create
    return if @chat.generating?
    @message = @chat.messages.create!(message_params)
    @chat.update!(generating: true)
    GenerateJob.perform_later(@chat)
    redirect_to chat_messages_path(@chat)
  end

  private

  def fetch_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end

class MessagesController < ApplicationController
  before_action :fetch_chat

  def index
    @messages = @chat.messages.all.order(created_at: :asc)
  end

  def create
    return if @chat.generating?
    @message = @chat.messages.create!(role: "user", **message_params)
    ChatJob.perform_later(@chat)
    GenerateChatTitleJob.perform_later(@chat) unless @chat.title.present?
  end

  private

  def fetch_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end

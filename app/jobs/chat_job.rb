class ChatJob < ApplicationJob
  queue_as :default

  def perform(chat)
    generated_message = chat.messages.create!(content: "", role: "assistant")
    client.chat({ model: "llava", messages: chat.to_ollama, stream: true }) do |event|
      generated_message.content << event.dig("message", "content")
      generated_message.broadcast_replace_to(chat)
    end
    generated_message.save!
  end

  private

  def client
    @client ||= Ollama.new(credentials: { address: "http://xeon:11434" }, options: { server_sent_events: true })
  end
end

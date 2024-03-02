class GenerateJob < ApplicationJob
  queue_as :default

  def perform(chat)
    generated_message = chat.messages.create!(body: "")
    client.generate({ model: "llava", prompt: chat.prompt, stream: true }) do |event|
      generated_message.update!(body: "#{generated_message.body}#{event["response"]}")
    end
    chat.update!(generating: false)
  end

  private

  def client
    @client ||= Ollama.new(credentials: { address: "http://localhost:11434" }, options: { server_sent_events: true })
  end
end

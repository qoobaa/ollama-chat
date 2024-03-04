class GenerateChatTitleJob < ApplicationJob
  queue_as :default

  def perform(chat)
    prompt = "Create a concise, 3-5 word phrase as a header for the following query, strictly adhering to the 3-5 word limit and avoiding the use of the word 'title': #{chat.messages.first.content}"
    response = client.generate({ model: "llava", prompt: prompt, stream: false })
    chat.update!(title: response.dig(0, "response").strip.gsub(/[^a-zA-Z0-9\s]/, ""))
  end

  private

  def client
    @client ||= Ollama.new(credentials: { address: "http://xeon:11434" })
  end
end

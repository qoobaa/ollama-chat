class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy

  def generating?
    messages.last&.content == ""
  end

  def to_ollama
    messages.pluck(:content, :role).map { |content, role| { content:, role: } }
  end
end

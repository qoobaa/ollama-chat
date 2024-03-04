class Message < ApplicationRecord
  belongs_to :chat
  broadcasts_to :chat

  enum role: { user: 1, assistant: 2 }
end

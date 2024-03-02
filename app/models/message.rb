class Message < ApplicationRecord
  belongs_to :chat
  broadcasts_to :chat
end

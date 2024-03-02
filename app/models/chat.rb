class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy

  def prompt
    messages.pluck(:body).join("\n")
  end
end

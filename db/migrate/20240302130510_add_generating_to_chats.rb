class AddGeneratingToChats < ActiveRecord::Migration[7.1]
  def change
    add_column :chats, :generating, :boolean
  end
end

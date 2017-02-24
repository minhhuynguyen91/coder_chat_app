class AddImageToMessages < ActiveRecord::Migration[5.0]
  def change
    add_attachment :messages, :image, :attachment
  end
end

class CreateBlocklists < ActiveRecord::Migration[5.0]
  def change
    create_table :blocklists do |t|
      t.integer :user_id
      t.integer :block_id

      t.timestamps
    end
  end
end

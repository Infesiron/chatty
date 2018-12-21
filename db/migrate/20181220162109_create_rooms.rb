class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.text :title
      t.boolean :hidden, default: true

      t.timestamps
    end
  end
end

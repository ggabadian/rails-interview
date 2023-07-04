class AddTodoItems < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_items do |t|
      t.string :name
      t.string :description
      t.boolean :completed
      t.references :todo_list

      t.timestamps
    end
  end
end

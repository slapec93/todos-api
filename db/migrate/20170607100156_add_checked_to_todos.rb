class AddCheckedToTodos < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :checked, :boolean, default: false
  end
end

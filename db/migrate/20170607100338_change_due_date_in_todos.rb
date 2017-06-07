class ChangeDueDateInTodos < ActiveRecord::Migration[5.1]
  def up
    remove_column :todos, :due_date
    add_column :todos, :due_date, :date
  end

  def down
    remove_column :todos, :due_date, :date
    add_column :todos, :due_date, :string
  end
end

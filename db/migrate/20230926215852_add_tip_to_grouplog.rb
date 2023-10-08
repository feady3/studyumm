class AddTipToGrouplog < ActiveRecord::Migration[7.0]
  def change
    add_column :grouplogs, :tip, :text
  end
end

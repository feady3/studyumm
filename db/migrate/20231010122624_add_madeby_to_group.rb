class AddMadebyToGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :madeby, :string
  end
end

class AddTotalToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :total, :integer
  end
end

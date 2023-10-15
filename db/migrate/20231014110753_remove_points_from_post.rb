class RemovePointsFromPost < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :math1, :integer
    remove_column :posts, :math2, :integer
    remove_column :posts, :en1, :integer
    remove_column :posts, :en2, :integer
    remove_column :posts, :ja1, :integer
    remove_column :posts, :ja2, :integer
    remove_column :posts, :sci1, :integer
    remove_column :posts, :sci2, :integer
    remove_column :posts, :soc1, :integer
    remove_column :posts, :soc2, :integer
  end
end

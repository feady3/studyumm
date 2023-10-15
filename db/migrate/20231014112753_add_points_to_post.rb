class AddPointsToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :math1, :integer
    add_column :posts, :math2, :integer
    add_column :posts, :en1, :integer
    add_column :posts, :en2, :integer
    add_column :posts, :ja1, :integer
    add_column :posts, :ja2, :integer
    add_column :posts, :sci1, :integer
    add_column :posts, :sci2, :integer
    add_column :posts, :soc1, :integer
    add_column :posts, :soc2, :integer
  end
end

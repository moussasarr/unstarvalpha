class AddTitleToGrouposts < ActiveRecord::Migration
  def change
    add_column :grouposts, :title, :string
  end
end

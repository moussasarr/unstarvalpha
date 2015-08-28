class AddPictureToGrouposts < ActiveRecord::Migration
  def change
    add_column :grouposts, :picture, :string
  end
end

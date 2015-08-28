class CreateComments < ActiveRecord::Migration
  def change
  	
    create_table :comments do |t|
      t.string :author_name
      t.text :body
      t.references :post, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps

    end
    add_index :comments, [:user_id, :post_id, :created_at]

  end
end

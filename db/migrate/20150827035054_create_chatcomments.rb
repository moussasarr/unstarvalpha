class CreateChatcomments < ActiveRecord::Migration
  def change
    create_table :chatcomments do |t|
      t.text :body

      t.references :user, index: true, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
    
  end
end

class CreateGroupchatcomments < ActiveRecord::Migration
  def change
    create_table :groupchatcomments do |t|
      t.text :body
      t.references :user, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true

      t.timestamps
    end
  end
end

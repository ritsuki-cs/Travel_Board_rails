class CreateMicropostTagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :micropost_tag_relations do |t|
      t.references :micropost, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    add_index :micropost_tag_relations, [:micropost_id, :tag_id], unique: true
  end
end

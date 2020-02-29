class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :tags_name, null: false
      t.timestamps
    end
    add_index :tags, :tags_name, unique: true
  end
end

class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.integer :price

      t.timestamps null: false
      
      t.index [:user_id, :created_at]
    end
  end
end

class AddSlugToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :slug, :string
    add_index :carts, :slug, unique: true
  end
end

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :comment
      t.integer :customer_id
      t.integer :product_id

      t.timestamps
    end
  end
end

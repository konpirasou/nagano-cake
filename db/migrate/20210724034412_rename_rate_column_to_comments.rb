class RenameRateColumnToComments < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :rate, :integer
  end
end

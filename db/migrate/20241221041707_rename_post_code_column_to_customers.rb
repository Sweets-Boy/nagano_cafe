class RenamePostCodeColumnToCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :post_code, :postal_code
  end
end

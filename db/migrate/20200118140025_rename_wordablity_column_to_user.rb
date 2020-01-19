class RenameWordablityColumnToUser < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :wordablity, :wordability
  end
end

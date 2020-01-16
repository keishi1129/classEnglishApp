class AddUserIdtoCardsets < ActiveRecord::Migration[6.0]
  def change
    add_reference :cardsets, :user, foreign_key: true
  end
end

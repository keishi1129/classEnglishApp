class AddStatusIdtoposts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :use, :integer, default:1
    add_reference :posts, :user, foreign_key: true
  end
end


class AddClassroomIdToCardset < ActiveRecord::Migration[6.0]
  def change
    add_reference :cardsets, :classroom, foreign_key: true
  end
end

class ChangeUserIdToBeOptionalInProducts < ActiveRecord::Migration[7.2]
  def change
    change_column_null :products, :user_id, true
  end
end
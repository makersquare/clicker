class ChangeStateToDefaultPending < ActiveRecord::Migration
  def change
    change_column_default :questions, :state, "pending"
    change_column_default :question_sets, :state, "pending"
  end
end

class AddRemoveColumnsQuestionSets < ActiveRecord::Migration
  def change
    add_column :question_sets, :state, :string
    remove_column :question_sets, :active, :boolean    
  end
end

class AddColumnQuestionSet < ActiveRecord::Migration
  def change
    change_table :question_sets do |t|
      t.boolean :active, :default => false
    end      
  end
end

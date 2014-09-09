class CreateQuestionSets < ActiveRecord::Migration
  def change
    create_table :question_sets do |t|
      t.belongs_to :class_group
      t.string :name

      t.timestamps
    end
  end
end

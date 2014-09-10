class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :question_set
      t.string :type
      t.json :content

      t.timestamps
    end
  end
end

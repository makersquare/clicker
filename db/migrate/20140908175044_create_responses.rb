class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.belongs_to :question
      t.belongs_to :user
      t.json :content

      t.timestamps
    end
  end
end

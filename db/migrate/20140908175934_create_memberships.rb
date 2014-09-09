class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :user
      t.belongs_to :class_group
      t.string :kind

      t.timestamps
    end
  end
end

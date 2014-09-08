class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.boolean :teacher

      t.timestamps
    end
  end
end

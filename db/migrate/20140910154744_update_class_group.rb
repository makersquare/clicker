class UpdateClassGroup < ActiveRecord::Migration
  def change
    change_table :class_groups do |t|
      t.text :description
    end    
  end
end

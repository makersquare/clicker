class AddGravatarColumnUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :gravatar_id
    end  
  end
end

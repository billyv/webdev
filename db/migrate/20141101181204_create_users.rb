class CreateUsers < ActiveRecord::Migration
  def change
    create_table :todo_users do |t|
      t.string :name
    end

     change_table :todo_items do |t|
      t.integer :todo_user_id
    end
  end
end

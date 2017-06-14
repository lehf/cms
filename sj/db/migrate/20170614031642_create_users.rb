class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.integer :type
      t.boolean :status
      t.integer :datatype
      t.string :website
      t.string :description

      t.timestamps null: false
    end
  end
end

class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.text :text

      t.timestamps
    end
    add_index :pages, :name, unique:true
  end
end

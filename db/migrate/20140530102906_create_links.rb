class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :original
      t.string :shorten

      t.text :message

      t.boolean :public, default: true
      # default is public ( requires no password )

      t.timestamps
    end

    add_index :links, :original, unique: true
    add_index :links, :shorten, unique: true
  end
end

class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :original
      t.string :shorten

      t.string :title
      # will parse title from html file

      t.boolean :public, default: true
      # default is public ( requires no password )

      t.string :authenticate, default: nil

      t.timestamps
    end

    add_index :links, :original, unique: true
    add_index :links, :shorten, unique: true
  end
end

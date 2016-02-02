class CreateThemesTable < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :match_strengths do |t|
      t.integer :strength
      t.belongs_to :ingredient, index: true
      t.belongs_to :theme, index: true
      t.timestamps null: false
    end
  end
end

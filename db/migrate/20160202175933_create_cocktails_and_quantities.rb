class CreateCocktailsAndQuantities < ActiveRecord::Migration
  def change
    create_table :cocktails do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :quantities do |t|
      t.string :amount
      t.belongs_to :ingredient, index: true
      t.belongs_to :cocktail, index: true
      t.timestamps null: false
    end
  end
end

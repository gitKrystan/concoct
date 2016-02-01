class CreateCategoriesIngredientsJoin < ActiveRecord::Migration
  def change
    create_table :categories_ingredients do |t|
      t.belongs_to :category, index: true
      t.belongs_to :ingredient, index: true
    end
  end
end

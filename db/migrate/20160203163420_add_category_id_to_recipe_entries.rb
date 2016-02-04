class AddCategoryIdToRecipeEntries < ActiveRecord::Migration
  def change
    change_table :recipe_entries do |t|
      t.belongs_to :category, index: true
    end
  end
end

class ChangeQuantitiesToRecipeEntries < ActiveRecord::Migration
  def change
    rename_table :quantities, :recipe_entries
  end
end

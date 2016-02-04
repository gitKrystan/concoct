class AddThemesToCocktails < ActiveRecord::Migration
  def change
    change_table :cocktails do |t|
      t.belongs_to :theme, index: true
    end
  end
end

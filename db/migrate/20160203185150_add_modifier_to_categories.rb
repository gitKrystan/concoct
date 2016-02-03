class AddModifierToCategories < ActiveRecord::Migration
  def change
    change_table :categories do |t|
      t.string :modifier
    end
  end
end

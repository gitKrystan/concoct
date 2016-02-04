class AddDefaultAmountsToCategories < ActiveRecord::Migration
  def change
    change_table :categories do |t|
      t.string :unit, default: 'oz'
      t.integer :default_amount, default: 1
    end
  end
end

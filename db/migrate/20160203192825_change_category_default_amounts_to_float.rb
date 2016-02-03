class ChangeCategoryDefaultAmountsToFloat < ActiveRecord::Migration
  def change
    change_column :categories, :default_amount, :float
  end
end

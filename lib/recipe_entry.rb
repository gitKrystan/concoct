class RecipeEntry < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :cocktail
  belongs_to :category
end

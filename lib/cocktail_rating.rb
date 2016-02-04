class CocktailRating < ActiveRecord::Base
  belongs_to :cocktail
  validates :score, presence: true
end

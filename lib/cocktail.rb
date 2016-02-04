class Cocktail < ActiveRecord::Base
  has_many :recipe_entries, :dependent => :destroy
  has_many :ingredients, through: :recipe_entries
  has_many :categories, through: :recipe_entries
  belongs_to :theme

  validates :name, presence: true

  before_save(:capitalize)

  def add_theme
    match_strengths = {}

    ingredients = self.ingredients
    ingredients.each do |ingredient|
      ingredient_match_strengths = ingredient.match_strength_hash

      # add up theme_strengths to the theme_strengths hash
      ingredient_match_strengths.each do |theme_id, ingredient_theme_strength|
        if ingredient_theme_strength > 0
          previous_strength = match_strengths[theme_id] || 0
          match_strengths[theme_id] = previous_strength + ingredient_theme_strength
        end
      end
    end

    # determine which theme_strength is the strongest
    strongest_theme_id = match_strengths.max_by{|k,v| v}[0]

    # and update cocktail with that theme
    
  end

private

  def capitalize
    self.name = name.split(" ").each { |w| w.capitalize! }.join(" ")
  end
end

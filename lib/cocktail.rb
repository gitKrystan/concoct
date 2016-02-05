class Cocktail < ActiveRecord::Base
  has_many :recipe_entries, :dependent => :destroy
  has_many :ingredients, through: :recipe_entries
  has_many :categories, through: :recipe_entries
  has_many :cocktail_ratings
  belongs_to :theme

  validates :name, presence: true

  before_save(:capitalize)

  def add_theme
    primaries = Category.ingredients_by('Primary')
    garnishes = Category.ingredients_by('Garnish')
    match_strengths = {}

    ingredients = self.ingredients
    ingredients.each do |ingredient|
      ingredient_match_strengths = ingredient.match_strength_hash
      if primaries.include?(ingredient)
        modifier = 2
      elsif garnishes.include?(ingredient)
        modifier = 0.5
      else
        modifier = 1
      end
      # add up theme_strengths to the theme_strengths hash
      ingredient_match_strengths.each do |theme_id, ingredient_theme_strength|
        if ingredient_theme_strength > 0
          previous_strength = match_strengths[theme_id] || 0
          match_strengths[theme_id] = previous_strength + (ingredient_theme_strength * modifier)
        end
      end
    end

    # determine which theme_strength is the strongest
    strongest_theme_id = match_strengths
      .max_by{|k,v| v}[0] unless match_strengths.empty?

    # and update cocktail with that theme
    self.update(theme_id: strongest_theme_id)
  end

  def theme_style
    theme = self.theme
    "theme-#{theme.name.downcase}" unless theme.nil?
  end

  def average_score
    @total = 0
    return nil if self.cocktail_ratings.empty?
    self.cocktail_ratings.each do |rating|
      @total += rating.score
    end
    return (@total.fdiv(self.cocktail_ratings.length)).round(1)
  end

  def rating_tally
    return self.cocktail_ratings.empty? ? nil : self.cocktail_ratings.length
  end

  def self.list_all_in_order
    Cocktail.where.not(name: 'Temporary').order(:name)
  end

private

  def capitalize
    self.name = name.split(" ").each { |w| w.capitalize! }.join(" ")
  end
end

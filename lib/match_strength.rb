class MatchStrength < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :theme

  def self.create_update_strength_values(ingredient_id, strength_values)
    strength_values_exists?(ingredient_id) ? update_strength_values(ingredient_id, strength_values) : create_strength_values(ingredient_id, strength_values)

  end

  def self.create_strength_values(ingredient_id, strength_values)
    Theme.all.each do |theme|
      MatchStrength.create(ingredient_id: ingredient_id, theme_id: theme.id, strength: strength_values.fetch(theme.name))
    end
  end

  def self.update_strength_values(ingredient_id, strength_values)
    ingredient = Ingredient.find(ingredient_id)
    Theme.all.each do |theme|
      ingredient.match_strengths.detect { |ms| ms.theme_id == theme.id}.update(strength: strength_values.fetch(theme.name))
    end
  end

  def self.strength_values_exists?(ingredient_id)
    MatchStrength.find_by_ingredient_id(ingredient_id)
  end
end

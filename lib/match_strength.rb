class MatchStrength < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :theme

  def self.create_strength_values(ingredient_id, strength_values)
    Theme.all.each do |theme|
      MatchStrength.create(ingredient_id: ingredient_id, theme_id: theme.id, strength: strength_values.fetch(theme.name))
    end
  end
end

class RecipeEntry < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :cocktail
  belongs_to :category

  def adjust_amount(category_counts, strength, sweetness)
    category = self.category
    category_count = category_counts[category.id]
    if category_count > 0
      default_amount = category.default_amount
      preference_modifier = category.preference_modifier(strength, sweetness)
      adjusted_amount = (default_amount + preference_modifier) / category_count
      adjusted_amount = [adjusted_amount.round_to_nearest_quarter, 0.25].max
      adjusted_amount = adjusted_amount.to_rational_string
      adjusted_amount
      entry_amount = "#{adjusted_amount} #{category.unit}"
      self.update(amount: entry_amount)
    end
  end
end

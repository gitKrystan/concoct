require 'spec_helper'

describe(RecipeEntry) do
  describe('#adjust_amount') do
    it('adjusts entry amount depending on the user input') do
      test_category = create_category
      test_entry = test_category.recipe_entries.create
      strength = 1
      sweetness = 0
      category_counts = {test_category.id => 1}
      test_entry.adjust_amount(category_counts, strength, sweetness)
      expect(test_entry.amount).to(eq("2 oz"))
    end
  end
end

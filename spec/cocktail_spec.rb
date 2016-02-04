require "spec_helper"

describe(Cocktail) do
  it('validates the presence of the name') do
    test_cocktail = Cocktail.new(name: "")
    expect(test_cocktail.save).to(eq(false))
  end

  describe('#capitalize') do
    it ('capitalizes the name before save') do
      test_cocktail = create_test_cocktail
      expect(test_cocktail.name()).to(eq("Test Cocktail"))
    end
  end

  describe('#ingredients') do
    it('returns a list of ingredients used in the cocktail') do
      test_cocktail = create_test_cocktail()
      test_ingredient = test_cocktail.ingredients.create({
        name: "test ingredient"
        })
      expect(test_cocktail.ingredients).to(eq([test_ingredient]))
    end
  end

  describe('#recipe_entries') do
    it('returns a list of recipe entries for the cocktail') do
      test_cocktail = create_test_cocktail()
      test_ingredient = create_ingredient()
      test_category = Category.create(name: "primary")
      test_entry = test_cocktail.recipe_entries.create({
        ingredient_id: test_ingredient.id,
        category_id: test_category.id,
        amount: "1 oz"
        })
      expect(test_cocktail.recipe_entries).to(eq([test_entry]))
    end
  end

  describe('#add_theme') do
    it('associates a theme with a recipe based on ingredients') do
      test_cocktail = create_test_cocktail()
      test_theme = Theme.create(name: 'test_theme')
      test_theme2 = Theme.create(name: 'test_theme2')
      test_ingredient = create_ingredient
      test_cocktail.ingredients << test_ingredient
      test_ingredient.match_strengths.create({
        theme_id: test_theme.id,
        strength: 10
        })
      test_ingredient2 = create_ingredient_2
      test_cocktail.ingredients << test_ingredient2
      test_ingredient.match_strengths.create({
        theme_id: test_theme2.id,
        strength:10
        })
      test_cocktail.add_theme
      expect(test_cocktail.theme).to(eq(test_theme))
    end
  end
end

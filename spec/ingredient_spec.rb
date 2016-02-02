require 'spec_helper'

describe(Ingredient) do
  it('validates the presence of the name') do
    test_ingredient = Ingredient.new(name: "")
    expect(test_ingredient.save).to(eq(false))
  end

  it('capitalizes the ingredient name') do
    test_ingredient = Ingredient.create(name: "vodka")
    expect(test_ingredient.name).to(eq("Vodka"))
  end

  it('validates uniqueness of ingredient') do
    test_ingredient = create_ingredient
    expect(Ingredient.all.length).to eq(1)
    test_ingredient = create_ingredient
    expect(Ingredient.all.length).to eq(1)
  end

  it('creates join table record ingredient_category') do
    test_category = create_category
    test_ingredient = create_ingredient
    test_ingredient.categories << test_category
    expect(test_ingredient.categories).to eq([test_category])
  end

  describe('#ingredients') do
    it('returns a list of ingredients that go with the specified ingredient') do
      ingredient1 = create_ingredient
      ingredient2 = create_ingredient_2
      ingredient1.ingredients << ingredient2
      ingredient2.ingredients << ingredient1
      expect(ingredient1.ingredients).to eq([ingredient2])
      expect(ingredient2.ingredients).to eq([ingredient1])
    end
  end

  describe('#cocktails') do
    it('returns a list of cocktails that use the ingredient') do
      test_cocktail = create_test_cocktail()
      test_ingredient = test_cocktail.ingredients.create({
        name: "test ingredient"
        })
      expect(test_ingredient.cocktails).to(eq([test_cocktail]))
    end
  end
end

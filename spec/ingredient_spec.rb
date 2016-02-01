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

  it('creates join table record ingredient_category') do
    test_category = create_category
    test_ingredient = create_ingredient
    test_ingredient.categories << test_category
    expect(test_ingredient.categories).to eq([test_category])
  end
end

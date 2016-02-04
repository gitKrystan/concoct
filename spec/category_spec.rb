require 'spec_helper'

describe(Category) do
  it('validates the presence of the name') do
    test_category = Category.new(name: "")
    expect(test_category.save).to(eq(false))
  end

  it('capitalizes the category name') do
    test_category = Category.create(name: "primary")
    expect(test_category.name).to(eq("Primary"))
  end

  it('creates join table record category_ingredient') do
    test_category = create_category
    test_ingredient = create_ingredient
    test_category.ingredients << test_ingredient
    expect(test_category.ingredients).to eq([test_ingredient])
  end

  describe('#adjust_amount_by_preference') do
    it('returns an amount modifier depending on the user input') do
      test_category = create_category
      strength = -1
      sweetness = 0
      expect(test_category.preference_modifier(strength, sweetness)).to(eq(-1))
    end
  end
end

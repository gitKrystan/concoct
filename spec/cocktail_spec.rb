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
end

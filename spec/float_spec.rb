require "spec_helper"

describe(Float) do
  describe('#to_rational_string') do
    it('returns a string of a mixed rational number') do
      test_fraction = 0.5
      expect(test_fraction.to_rational_string).to(eq("1/2"))
    end
  end
end

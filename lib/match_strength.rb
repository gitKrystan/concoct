class MatchStrength < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :theme
end

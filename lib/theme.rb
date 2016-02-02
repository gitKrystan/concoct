class Theme < ActiveRecord::Base
  has_many :match_strengths
  has_many :ingredients, through: :match_strengths
end

class Theme < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :theme
end

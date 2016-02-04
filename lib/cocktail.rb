class Cocktail < ActiveRecord::Base
  has_many :recipe_entries, :dependent => :destroy
  has_many :ingredients, through: :recipe_entries
  has_many :categories, through: :recipe_entries
  
  validates :name, presence: true

  before_save(:capitalize)

private

  def capitalize
    self.name = name.split(" ").each { |w| w.capitalize! }.join(" ")
  end
end

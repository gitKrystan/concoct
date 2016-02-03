class Cocktail < ActiveRecord::Base
  has_many :quantities, :dependent => :destroy
  has_many :ingredients, through: :quantities

  validates :name, presence: true

  before_save(:capitalize)

private

  def capitalize
    self.name = name.split(" ").each { |w| w.capitalize! }.join(" ")
  end
end

class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many :categories
  before_save(:capitalize)

  validates :name, presence: true

  private

  def capitalize
    self.name = name.split(" ").each { |w| w.capitalize! }.join(" ")
  end
end

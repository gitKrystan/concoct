class Category < ActiveRecord::Base
  has_and_belongs_to_many :ingredients
  has_many :recipe_entries, :dependent => :destroy
  has_many :cocktails, through: :recipe_entries

  before_save(:capitalize)

  validates :name, presence: true

  def self.ingredients_by(category)
    Category.find_by(name: category).ingredients.order(:name)
  end

  def self.find_id_by_name(name)
    Category.find_by(name: name.capitalize).order(:name).id
  end

private

  def capitalize
    self.name = name.split(" ").each { |w| w.capitalize! }.join(" ")
  end
end

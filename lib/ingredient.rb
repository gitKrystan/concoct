class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :ingredients,
              class_name: "Ingredient",
              join_table: :combinations,
              foreign_key: :ingredient_id,
              association_foreign_key: :complement_id
  has_many :recipe_entries, :dependent => :destroy
  has_many :cocktails, through: :recipe_entries
  has_many :match_strengths, :dependent => :destroy
  has_many :themes, through: :match_strengths

  before_save(:capitalize)

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.find_unless_none(id)
    Ingredient.find(id.to_i) unless id == ""
  end

private

  def capitalize
    self.name = name.split(" ").each { |w| w.capitalize! }.join(" ")
  end
end

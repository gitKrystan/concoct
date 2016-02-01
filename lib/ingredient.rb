class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :ingredients,
              class_name: "Ingredient",
              join_table: :combinations,
              foreign_key: :ingredient_id,
              association_foreign_key: :complement_id

  before_save(:capitalize)

  validates :name, presence: true

  private

  def capitalize
    self.name = name.split(" ").each { |w| w.capitalize! }.join(" ")
  end
end

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

  def match_strength_hash
    match_strength_hash = {}
    match_strengths = self.match_strengths
    match_strengths.each do |match|
      match_strength_hash.store(match.theme_id, match.strength)
    end
    match_strength_hash
  end

  def primary_theme
    match_strengths = self.match_strength_hash
    Theme.find(match_strengths.max_by{|k,v| v}[0]) unless match_strengths.empty?
  end

  def theme_style
    theme = self.primary_theme
    "theme-#{theme.downcase}" unless theme.nil?
  end

  def value(theme_id)
    value = self.match_strengths.empty? ? 0 : self.match_strengths.find_by_theme_id(theme_id).strength
  end

  def self.find_unless_none(id)
    Ingredient.find(id.to_i) unless id == ""
  end

private

  def capitalize
    self.name = name.split(" ").each { |w| w.capitalize! }.join(" ")
  end
end

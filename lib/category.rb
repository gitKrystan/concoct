class Category < ActiveRecord::Base
  has_and_belongs_to_many :ingredients
  before_save(:capitalize)

  validates :name, presence: true

  private

  def capitalize
    self.name = name.split(" ").each { |w| w.capitalize! }.join(" ")
  end
end

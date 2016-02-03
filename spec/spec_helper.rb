ENV['RACK_ENV'] = 'test'

require('bundler/setup')
Bundler.require(:default, :test)
set(:root, Dir.pwd())

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

require('capybara/rspec')
Capybara.app = Sinatra::Application
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
Capybara.javascript_driver = :chrome
Capybara.current_driver = Capybara.javascript_driver
set(:show_exceptions, false)
require('./app')

RSpec.configure do |config|
  config.after(:each) do
    Category.all().each() do |category|
      category.destroy()
    end
    Category.create({
      name: "Primary",
      modifier: "strength positive"
      })
    Category.create({
      name: "Secondary",
      modifier: "strength positive"
      })
    Category.create({
      name: "Sweetener",
      default_amount: 1,
      unit: "tsp",
      modifier: "sweetness positive"
      })
    Category.create({
      name: "Acid",
      default_amount: 1,
      modifier: "sweetness negative"
      })
    Category.create({
      name: "Mixer",
      default_amount: 2,
      modifier: "strength negative"
      })
    Category.create({
      name: "Garnish",
      default_amount: 1,
      unit: "",
      modifier: "none"
      })
    Category.create({
      name: "Aromatic",
      default_amount: 3,
      unit: "drops",
      modifier: "none"
      })
    Ingredient.all().each() do |ingredient|
      ingredient.destroy()
    end
  end
end

def create_ingredient
  Ingredient.create(name: "Liquor")
end

def create_ingredient_2
  Ingredient.create(name: "Rum")
end

def create_category
  Category.create(name: "Primary" )
end

def create_test_cocktail
  Cocktail.create({name: "test cocktail"})
end

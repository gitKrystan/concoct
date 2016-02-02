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
    Category.create(name: "Primary")
    Category.create(name: "Secondary")
    Category.create(name: "Sweetener")
    Category.create(name: "Acid")
    Category.create(name: "Mixer")
    Category.create(name: "Garnish")
    Category.create(name: "Aromatic")
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

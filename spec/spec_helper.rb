ENV['RACK_ENV'] = 'test'

require('bundler/setup')
Bundler.require(:default, :test)
set(:root, Dir.pwd())

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

require('capybara/rspec')
Capybara.app = Sinatra::Application

set(:show_exceptions, false)
require('./app')

RSpec.configure do |config|
  config.after(:each) do
    Category.all().each() do |category|
      category.destroy()
    end
    Ingredient.all().each() do |ingredient|
      ingredient.destroy()
    end
  end
end

def create_ingredient
  Ingredient.create(name: "Liquor")
end

def create_category
  Category.create(name: "Primary" )
end

require "bundler/setup"
require "pry"
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

# USER INTERFACE ROUTES
get '/' do
  erb :index
end

# CREATE cocktail
get '/cocktails/new' do
  @ingredients = []
  @primaries = Category.ingredients_by('Primary')
  @secondaries = Category.ingredients_by('Secondary')
  @sweeteners = Category.ingredients_by('Sweetener')
  @acids = Category.ingredients_by('Acid')
  @mixers = Category.ingredients_by('Mixer')
  @garnishes = Category.ingredients_by('Garnish')
  @aromatics = Category.ingredients_by('Aromatic')
  erb :cocktail_form
end

post '/cocktails' do
  cocktail = Cocktail.create(name: "Temporary")
  primary = Ingredient.find_unless_none(params[:primary])
  secondary = Ingredient.find_unless_none(params[:secondary])
  sweetener = Ingredient.find_unless_none(params[:sweetener])
  acid = Ingredient.find_unless_none(params[:acid])
  mixer = Ingredient.find_unless_none(params[:mixer])
  garnish = Ingredient.find_unless_none(params[:garnish])
  aromatic = Ingredient.find_unless_none(params[:aromatic])
  cocktail.ingredients << primary
  # TODO: update whatever ingredient was chosen
  redirect "/cocktails/#{cocktail.id}/edit"
end

# READ cocktail
get '/cocktails/:id' do
  erb :cocktail
end

# UPDATE cocktail
get '/cocktails/:id/edit' do
  cocktail = Cocktail.find(params[:id].to_i)
  @ingredients = cocktail.ingredients
  @primaries = Category.ingredients_by('Primary')
  @secondaries = Category.ingredients_by('Secondary')
  @sweeteners = Category.ingredients_by('Sweetener')
  @acids = Category.ingredients_by('Acid')
  @mixers = Category.ingredients_by('Mixer')
  @garnishes = Category.ingredients_by('Garnish')
  @aromatics = Category.ingredients_by('Aromatic')
  erb :cocktail_form
end

patch '/cocktails/:id' do
  # TODO: update cocktail info here
end

# TODO: DELETE cocktail

# ADMIN PORTAL ROUTES: CRUD for ingredients
get '/admin' do
  @ingredients = Ingredient.all().order(:name)
  erb :admin
end

get '/ingredients' do
  @ingredients = Ingredient.all
  erb :ingredients
end

# CREATE ingredient
get '/ingredients/new' do
  erb :ingredient_form
end

post '/ingredients' do
  ingredient = Ingredient.create(name: params[:ingredient_name])
  redirect "/ingredients/#{ingredient.id}/edit"
end

# EDIT ingredient
get '/ingredients/:id/edit' do
  @ingredient = Ingredient.find(params[:id].to_i)
  @ingredient_categories = @ingredient.categories.order(:name)
  @add_categories = Category.order(:name) - @ingredient_categories
  erb :ingredients_edit
end

post '/ingredients/:id/categories' do
  ingredient = Ingredient.find(params[:id].to_i)
  category = Category.find(params[:category_id].to_i)
  ingredient.categories << category
  redirect "/ingredients/#{ingredient.id}/edit"
end

delete '/ingredients/:id/categories' do
  ingredient = Ingredient.find(params[:id].to_i)
  category = Category.find(params[:category_id].to_i)
  ingredient.categories.delete(category)
  redirect "/ingredients/#{ingredient.id}/edit"
end

# READ ingredient
get '/ingredients/:id' do
  @ingredient =  Ingredient.find(params[:id].to_i)
  erb :ingredient
end

# UPDATE ingredient
patch '/ingredients/:id' do
  ingredient = Ingredient.find(params[:id].to_i)
  ingredient.update(name: params[:ingredient_name])
  redirect "/ingredients/#{ingredient.id}/edit"
end

# DELETE ingredient
delete '/ingredients/:id' do
  ingredient = Ingredient.find(params[:id].to_i)
  ingredient.destroy
  redirect '/admin'
end

helpers do
  def options(list, param_name, class_additions = nil)
    html = "<select class='form-control #{class_additions}' name='#{param_name}'>\n \
      <option>None</option>"
    list.each do |item|
      html << "<option value='#{item.id}'>#{item.name}</option>"
    end
    html << "</select>"
    html
  end

  def ingredient_entry(ingredient, amount)
    "<h5>#{amount} #{ingredient}</h5>" unless ingredient.nil?
  end
end

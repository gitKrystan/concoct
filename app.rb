require "bundler/setup"
require "pry"
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

enable :sessions #for flash to work

# USER INTERFACE ROUTES
get '/' do
  @ingredients = Category.ingredients_by('Primary')
  erb :index
end

# CREATE cocktail
get '/cocktails/new' do
  @route = '/cocktails'
  @ingredients = []
  @cocktail = Cocktail.new
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
  add_ingredients(cocktail, params)

  redirect "/cocktails/#{cocktail.id}/edit"
end

# READ cocktail
get '/cocktails/:id' do
  id = params[:id].to_i
  @cocktail = Cocktail.find(id)
  @ingredients = @cocktail.ingredients
  erb :cocktail
end

# UPDATE cocktail
get '/cocktails/:id/edit' do
  id = params[:id].to_i
  @cocktail = Cocktail.find(id)
  @route = "/cocktails/#{id}/ingredients"

  @ingredients = @cocktail.ingredients
  combo_ingredients = @ingredients.to_a.shift.ingredients
  @ingredients.each do |ingredient|
    combo_ingredients = ingredient.ingredients & combo_ingredients
  end

  @primaries = Category.ingredients_by('Primary') & combo_ingredients
  @secondaries = Category.ingredients_by('Secondary') & combo_ingredients
  @sweeteners = Category.ingredients_by('Sweetener') & combo_ingredients
  @acids = Category.ingredients_by('Acid') & combo_ingredients
  @mixers = Category.ingredients_by('Mixer') & combo_ingredients
  @garnishes = Category.ingredients_by('Garnish') & combo_ingredients
  @aromatics = Category.ingredients_by('Aromatic') & combo_ingredients
  erb :cocktail_form
end

post '/cocktails/:id/ingredients' do
  id = params[:id].to_i
  cocktail = Cocktail.find(id)
  add_ingredients(cocktail, params)

  redirect "/cocktails/#{id}/edit"
end

delete '/cocktails/:cocktail_id/ingredients/:ingredient_id' do
  id = params[:cocktail_id].to_i
  cocktail = Cocktail.find(id)
  ingredient_id = params[:ingredient_id].to_i
  ingredient = Ingredient.find(ingredient_id)
  cocktail.ingredients.delete(ingredient)
  if cocktail.ingredients.length > 0
    redirect "/cocktails/#{id}/edit"
  else
    redirect "/cocktails/new"
  end
end

patch '/cocktails/:id' do
  id = params[:id].to_i
  cocktail = Cocktail.find(id)
  cocktail.update(name: params[:name])

  strength = params[:strength].to_i
  sweetness = params[:sweetness].to_i

  ingredients = cocktail.ingredients
  ingredients.each do |ingredient|

  end

  redirect "/cocktails/#{id}"
end

# ADMIN PORTAL ROUTES: CRUD for ingredients
get '/admin' do
  @ingredients = Ingredient.all().order(:name)
  @cocktails = Cocktail.all().order(:name)
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
  if Ingredient.create(name: params[:ingredient_name]).errors.any?
    flash[:warning] = "Ingredient \"#{params[:ingredient_name]}\" already exists"
    redirect "/admin"
  else
    ingredient = Ingredient.all.last
    flash[:success] = "Successfully created ingredient."
    redirect "/ingredients/#{ingredient.id}/edit"
  end
end

# READ ingredient
get '/ingredients/:id' do
  @ingredient = Ingredient.find(params[:id].to_i)
  @cocktails = @ingredient.cocktails.order(:name)
  erb :ingredient
end

# EDIT ingredient
get '/ingredients/:id/edit' do
  #ingredents/categories
  @ingredient = Ingredient.find(params[:id].to_i)
  @ingredient_categories = @ingredient.categories.order(:name)
  @add_categories = Category.order(:name) - @ingredient_categories
  #ingredents/combinations
  @ingredient_combinations = @ingredient.ingredients.order(:name)
  @add_combinations = Ingredient.order(:name) - @ingredient_combinations - [@ingredient]
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

post '/ingredients/:id/ingredients' do
  ingredient = Ingredient.find(params[:id].to_i)
  combo_ingredient = Ingredient.find(params[:combo_id].to_i)
  ingredient.ingredients << combo_ingredient
  combo_ingredient.ingredients << ingredient
  redirect "/ingredients/#{ingredient.id}/edit"
end

delete '/ingredients/:id/ingredients' do
  ingredient = Ingredient.find(params[:id].to_i)
  combo_ingredient = Ingredient.find(params[:combo_id].to_i)
  ingredient.ingredients.delete(combo_ingredient)
  combo_ingredient.ingredients.delete(ingredient)
  redirect "/ingredients/#{ingredient.id}/edit"
end

post '/ingredients/:id/themes' do
  ingredient = Ingredient.find(params[:id].to_i)
  MatchStrength.create_strength_values(params[:id].to_i, params)
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

# DELETE cocktail
delete '/cocktails/:id' do
  cocktail = Cocktail.find(params[:id].to_i)
  cocktail.destroy
  redirect "/admin"
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

  def add_ingredients(cocktail, params)
    primary = Ingredient.find_unless_none(params[:primary])
    secondary = Ingredient.find_unless_none(params[:secondary])
    sweetener = Ingredient.find_unless_none(params[:sweetener])
    acid = Ingredient.find_unless_none(params[:acid])
    mixer = Ingredient.find_unless_none(params[:mixer])
    garnish = Ingredient.find_unless_none(params[:garnish])
    aromatic = Ingredient.find_unless_none(params[:aromatic])

    cocktail.ingredients << primary unless primary.nil?
    cocktail.ingredients << secondary unless secondary.nil?
    cocktail.ingredients << sweetener unless sweetener.nil?
    cocktail.ingredients << acid unless acid.nil?
    cocktail.ingredients << mixer unless mixer.nil?
    cocktail.ingredients << garnish unless garnish.nil?
    cocktail.ingredients << aromatic unless aromatic.nil?
  end
end

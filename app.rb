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
  @primary = Category.ingredients_by('Primary')
  @secondary = Category.ingredients_by('Secondary')
  @sweetener = Category.ingredients_by('Sweetener')
  @acid = Category.ingredients_by('Acid')
  @mixer = Category.ingredients_by('Mixer')
  @garnish = Category.ingredients_by('Garnish')
  @aromatic = Category.ingredients_by('Aromatic')
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
  recipe_entries = @cocktail.recipe_entries
  primary_entries = recipe_entries
    .where(category_id: Category.find_id_by_name('Primary'))
  secondary_entries = recipe_entries
    .where(category_id: Category.find_id_by_name('Secondary'))
  sweet_entries = recipe_entries
    .where(category_id: Category.find_id_by_name('Sweetener'))
  acid_entries = recipe_entries
    .where(category_id: Category.find_id_by_name('Acid'))
  mixer_entries = recipe_entries
    .where(category_id: Category.find_id_by_name('Mixer'))
  aromatic_entries = recipe_entries
    .where(category_id: Category.find_id_by_name('Aromatic'))
  @garnish_entries = recipe_entries
    .where(category_id: Category.find_id_by_name('Garnish'))
  @stir_in_entries = primary_entries + secondary_entries + sweet_entries \
    + acid_entries + mixer_entries + aromatic_entries
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

  @primary = Category.ingredients_by('Primary') & combo_ingredients
  @secondary = Category.ingredients_by('Secondary') & combo_ingredients
  @sweetener = Category.ingredients_by('Sweetener') & combo_ingredients
  @acid = Category.ingredients_by('Acid') & combo_ingredients
  @mixer = Category.ingredients_by('Mixer') & combo_ingredients
  @garnish = Category.ingredients_by('Garnish') & combo_ingredients
  @aromatic = Category.ingredients_by('Aromatic') & combo_ingredients
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

  strength = params[:strength].to_f
  sweetness = params[:sweetness].to_f

  recipe_entries = cocktail.recipe_entries

  category_counts = {}
  Category.all.each do |category|
    category_id = category.id
    category_count = recipe_entries.where(category_id: category_id).count
    category_counts[category_id] = category_count
  end

  recipe_entries.each do |entry|
    category = entry.category
    category_count = category_counts[category.id]
    if category_count > 0
      default_amount = category.default_amount
      modifier_type = category.modifier
      case modifier_type
      when 'strength positive'
        preference_modifier = strength * default_amount
      when 'strength negative'
        preference_modifier =  -strength * default_amount
      when 'sweetness positive'
        preference_modifier = sweetness * default_amount
      when 'sweetness negative'
        preference_modifier = -sweetness * default_amount
      else
        preference_modifier = 0
      end
      adjusted_amount = (default_amount + preference_modifier) / category_count
      adjusted_amount = [adjusted_amount.round_to_nearest_quarter, 0.25].max
      adjusted_amount = adjusted_amount.to_rational_string
      entry_amount = "#{adjusted_amount} #{category.unit}"
      entry.update(amount: entry_amount)
    end
  end

  redirect "/cocktails/#{id}"
end

# ADMIN PORTAL ROUTES: CRUD for ingredients
get '/admin' do
  @ingredients = Ingredient.order(:name)
  @cocktails = Cocktail.order(:name)
  @categories = Category.order(:name)
  erb :admin
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

# EDIT categories
get '/categories/:id/edit' do
  @category = Category.find(params[:id])
  erb :category_edit
end

patch '/categories/:id' do
  category = Category.find(params[:id])
  category.update({
    default_amount: params[:default_amount],
    unit: params[:unit],
    modifier: params[:modifier]
    })
  flash[:success] = "Successfully updated category."
  redirect "/admin"
end

helpers do
  def options(list, param_name, class_additions = nil)
    html = "<select class='form-control #{class_additions}' name='#{param_name}'>\n \
      <option value='0'>None</option>"
    list.each do |item|
      html << "<option value='#{item.id}'>#{item.name}</option>"
    end
    html << "</select>"
    html
  end

  def entry_generator(entry)
    unless entry.ingredient.nil?
      "<dt> \
        #{entry.amount} \
      </dt> \
      <dd> \
        #{entry.ingredient.name} \
      </dd>"
    end
  end

  def garnish_entry_generator(entry)
    unless entry.ingredient.nil?
      "<dt> \
      </dt> \
      <dd> \
        <p>#{entry.ingredient.name}</p> \
      </dd>"
    end
  end

  def add_ingredients(cocktail, params)
    params.each do |param|
      ingredient_id = param[1].to_i
      if ingredient_id > 0
        category_id = param[0].to_i
        return cocktail.recipe_entries.create({
          ingredient_id: ingredient_id,
          category_id: category_id
          })
      end
    end
  end
end

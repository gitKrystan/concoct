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
  erb :cocktail_form
end

post '/cocktails' do
  erb :cocktail
end

# ADMIN PORTAL ROUTES: CRUD for ingredients
get '/admin' do
  erb :admin
end

# CREATE ingredient
get '/ingredients/new' do
  erb :ingredient_form
end

post '/ingredients' do
  # TODO: post new ingredient. Redirect to that ingredient's page.
  redirect "/ingredients/1"
end

# READ ingredient
get '/ingredients/1' do
  # TODO: This page should render a specific ingredient based on id
  erb :ingredient
end

# UPDATE ingredient
patch '/ingredients/1' do
  # TODO: patch ingredient. Redirect to that ingredient's page.
  redirect "/ingredients/1"
end

# DELETE ingredient
delete '/ingredients/1' do
  # TODO: delete ingredient. Redirect to that ingredient's page.
  redirect '/admin'
end

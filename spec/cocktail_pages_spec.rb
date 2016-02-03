require 'spec_helper'

feature "create a new cocktail" do
  before do
    tequila = Category.find_by(name: 'Primary').ingredients.create(name: 'Tequila')
    cointreau = Category.find_by(name: 'Secondary').ingredients.create(name: 'Cointreau')
    Category.find_by(name: 'Primary').ingredients.create(name: 'Applejack')
    agave = Category.find_by(name: 'Sweetener').ingredients.create(name: 'Agave Nectar')
    Category.find_by(name: 'Acid').ingredients.create(name: 'Lime Juice')
    Category.find_by(name: 'Mixer').ingredients.create(name: 'Ginger Ale')
    Category.find_by(name: 'Aromatic').ingredients.create(name: 'Absinthe')
    Category.find_by(name: 'Garnish').ingredients.create(name: 'Salt')
    tequila.ingredients << cointreau
    tequila.ingredients << agave
    cointreau.ingredients << agave
  end

  scenario "allows the user to create a new cocktail based on their selections", :js => true do
    visit '/'
    click_link 'Create a new cocktail'
    select 'Applejack', :from => Category.find_id_by_name("primary").to_s
    click_button 'remove'
    select 'Tequila', :from => Category.find_id_by_name("primary").to_s
    select 'Cointreau', :from => Category.find_id_by_name("secondary").to_s
    expect(find_field(Category.find_id_by_name("secondary").to_s))
      .not_to have_content 'Applejack'
    select 'Agave Nectar', :from => Category.find_id_by_name("sweetener").to_s
    click_button 'GENERATE CONCOCTION'
    fill_in 'name', :with => 'Newgarita'
    click_button 'Generate'
    expect(page).to have_content 'Newgarita'
    expect(page).to have_content 'Tequila'
    expect(page).to have_content 'Cointreau'
    expect(page).to have_content 'Agave Nectar'
    expect(page).not_to have_content 'Applejack'
  end
end

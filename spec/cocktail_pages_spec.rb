require 'spec_helper'

feature "create a new cocktail" do
  before do
    Category.find_by(name: 'Primary').ingredients.create(name: 'Tequila')
    Category.find_by(name: 'Secondary').ingredients.create(name: 'Cointreau')
    Category.find_by(name: 'Sweetener').ingredients.create(name: 'Agave Nectar')
    Category.find_by(name: 'Acid').ingredients.create(name: 'Lime Juice')
    Category.find_by(name: 'Mixer').ingredients.create(name: 'Ginger Ale')
    Category.find_by(name: 'Aromatic').ingredients.create(name: 'Absinthe')
    Category.find_by(name: 'Garnish').ingredients.create(name: 'Salt')
end
  scenario "allows the user to create a new cocktail based on their selections" do
    visit '/'
    click_link 'Create a new cocktail'
    select 'Tequila', :from => 'primary'
    select 'Cointreau', :from => 'secondary'
    select 'Agave Nectar', :from => 'sweetener'
    select 'Lime Juice', :from => 'acid'
    select 'Salt', :from => 'garnish'
    fill_in 'name', :with => 'Newgarita'
    click_button 'CONCOCT'
    expect(page).to have_content 'Newgarita'
    expect(page).to have_content 'Tequila'
    expect(page).to have_content 'Cointreau'
    expect(page).to have_content 'Agave Nectar'
    expect(page).to have_content 'Lime Juice'
    expect(page).to have_content 'Salt'
  end
end

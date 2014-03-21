require 'spec_helper'
  
feature 'the landing page!' do 
  before(:each) do
    visit root_path
  end
  
  
  scenario 'is enthusiastic to a fault' do
    expect(page).to have_content("OKZUPID")
  end
  
  scenario 'entry to app is exclusively gated by image links' do
    page.should_not satisfy do |page|
      page.has_content?('Sign Up') or page.has_content?('Log In')
    end
  end

  scenario 'should not appear if already logged in' do
    expect(page).not_to have_content("Welcome to OKZUPID!!!")
  end
  
  scenario 'left image links to login page' do
    find("#login").click
    
    expect(page).to have_content('Welcome back')
  end
  
  scenario 'right image links to signup page' do
    find("#signup").click
    
    expect(page).to have_content('What sort of animal are you?')
  end
  
  scenario 'middle image logs user in as guest' do
    tony_the_tiger
    
    page.should have_content('Tony the Tiger')
  end
end
require 'spec_helper'

feature 'the authentication process' do
  
  scenario 'it redirects to the landing page on logout' do
    tony_the_tiger
    click_on 'Log Out'
    
    page.should have_content('WELCOME TO OKZUPID!!!')
  end
  
  scenario 'it requires you to be logged in to view a profile' do
    visit user_path(2)
    
    page.should have_content("WELCOME TO OKZPUPID!!!")
  end
end
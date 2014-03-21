require 'spec_helper'

feature 'the profile page!' do
  before(:each) { tony_the_tiger }

  scenario "displays the user's name and species" do
    expect(page).to have_content 'Tony the Tiger'
  end
  
  scenario "user can upload a profile picture via url" do
    fill_in "Image URL", with: "http://i.imgur.com/FTGpkbI.jpg"
    click_on "Ready For My Close-Up"
      
    expect(page).to have_css 'img', 'FTGpkbI.jpg'
  end
  
  scenario "user can answer essay questions" do
    fill_in "About Me", with: "I'm Grrrrreat!"
    click_on "Done!"
    
    expect(page).to have_content "I'm Grrrrreat!"
  end
  
  scenario "has a sidebar with link to private messaging inbox" do
    click_on 'Inbox'
    
    expect(page).to have_content 'You have no new messages. Get out there!'
  end
  
end
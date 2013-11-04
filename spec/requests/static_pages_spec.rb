require 'spec_helper'

describe "StaticPages" do
  
  describe "Home Page" do
  	it "Should have the content 'Sample app'"do
      visit "/static_pages/home"
      expect(page).to have_content("Sample app")
    end

    it "Shoud have the title 'Home'" do
      visit "/static_pages/home"
      expect(page).to have_title("Home")
    end
  end

  describe "Help Page" do
  	it "Should have the content 'Help" do
  	  visit '/static_pages/help'
  	  expect(page).to have_content("Help")
  	end
  end

  describe "About Page" do
  	it "Should have the content 'About'" do
  	  visit '/static_pages/about'
  	  expect(page).to have_content("About")
  	end
  end
end

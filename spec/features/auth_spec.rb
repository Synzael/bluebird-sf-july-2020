require "rails_helper"
# CAPPY LAND YAY

feature "sign up", type: :feature do
  background :each do
    visit new_user_path
    # before each scenario, go to the new user path
    # helper method that gives us the string "/users/new"
    # could use url but it would give us localhost:3000/users/new - but we don't need the whole thing
  end

  scenario "has a user sign up page" do
    # save_and_open_page
    expect(page).to have_content("Sign Up")
    # spelling, punctuation and capitalization matter! EVERYTHING MATTERS
  end

  scenario "takes a username and a password" do
    expect(page).to have_content("Username")
    # the view needs to have AT LEAST Username, but could have more (like Username:) - will still pass
    expect(page).to have_content("Password")
  end

  scenario "redirect to users show page and display users username on success" do
    fill_in "Username", with: "smart_cappy"
    fill_in "Email", with: "smart_cappy@cappy.com"
    fill_in "Password", with: "abcdef"
    fill_in "Age", with: 2
    fill_in "Political Affiliation", with: "cappy"
    # if spec can't find the label exactly, it won't work
    # can also use id to fill_in
    # save_and_open_page

    click_button "Sign Up"
    expect(page).to have_content("smart_cappy")

    user = User.find_by(username: "smart_cappy")
    expect(current_path).to eq(user_path(user))
    # save_and_open_page
    
  end
end
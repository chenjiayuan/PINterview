require "rails_helper"

feature "visiting the home page" do
	scenario "check welcome text does it contains welcome" do
		visit root_path
		expect(page).to have_title "Login"
	end

	scenario("check if can u access new user link from home") do
    visit root_path
    visit users_new_path
    expect(page).to have_title "Create New User"
  end    

  scenario "create valid new user" do 
    user = FactoryGirl.build_stubbed(:user, email: "ki.ey.kouch@berkeley.edu")    
    visit "/signup"     
    fill_in "username", with: user.username
    fill_in "password", with: user.password
    fill_in "email", with: user.email
    fill_in "grad_class", with: user.grad_class
    fill_in "major", with: user.major
    click_button "Create an account"     
    expect(page).to have_content "Welcome to Pinterview"
  end

  scenario "invalid email new user" do
    user = FactoryGirl.build_stubbed(:user) 
    visit root_path
    visit "/signup"
      
    fill_in "username", with: user.username
    fill_in "password", with: user.password
    fill_in "email", with: user.email
    fill_in "grad_class", with: user.grad_class
    fill_in "major", with: user.major
    click_button "Sign up"     

    expect(page).to have_error_message "Email is invalid"
  end

  scenario "valid login" do
    user = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
    visit "/login"
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Continue"
    expect(page).to have_content("Welcome to Pinterview")
  end

  scenario "check if it direct to new login page for hardlink to new pin path" do
    visit pins_new_path  
    expect(current_path).to eq sessions_new_path
  end

  scenario "Login and then click profile page button" do
    user = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
    visit "/login"
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Continue"    
    click_button "My Profile"
    expect(current_path).to eq users_show_path
    expect(page).to have_content("Welcome to Profile Page")
  end

  scenario "create new pin after login" do
    user = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
    visit "/login"
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Continue"
    expect(current_path).to eq root_path

    visit pins_new_path
    pin = FactoryGirl.build_stubbed(:pin)
    fill_in "position", with: pin.position
    fill_in "company", with: pin.company
    fill_in "date", with: pin.date
    fill_in "difficulty", with: pin.difficulty
    fill_in "type_interview", with: pin.type_interview
    fill_in "attire", with: pin.attire
    fill_in "questions", with: pin.questions
    fill_in "length", with: pin.length
    fill_in "description", with: pin.description
    click_button "Create Now"     
    
    expect(current_path).to eq root_path
    expect(user.pins).to eq 1
  end

	private

  def login(email, password)
	   fill_in "Email", with: email
	   fill_in "Password", with: password
	   click_button "Log in"
  end
end
require "rails_helper"
require "pp"

feature "All Features Test" do
	scenario "check if it direct to new login page for hardlink to new pin path" do
    visit pins_new_path  
    expect(current_path).to eq "/login"
  end

	scenario("check if u can access new user link from home") do
    visit root_path
    click_link('Signupbutton')
    expect(page).to have_content "SIGN UP"
  end    

 scenario "create valid new user" do 
   user = FactoryGirl.build_stubbed(:user, email: "ki.ey.kouch@berkeley.edu")
   visit "/signup"     
   fill_in "user_username", with: user.username
   fill_in "user_password", with: user.password
   fill_in "user_email", with: user.email   
   click_button "Create an account"
   expect(current_path).to eq "/"
 end

 scenario "invalid email new user" do
   user = FactoryGirl.build_stubbed(:user) 
   visit root_path
   visit "/signup"
      
   fill_in "user_username", with: user.username
   fill_in "user_password", with: user.password
   fill_in "user_email", with: user.email   
   click_button "Create an account"    

   expect(current_path).to eq "/signup"
 end

 scenario "valid login" do
   user = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
   visit "/login"
   fill_in "session_email", :with => user.email
   fill_in "session_password", :with => user.password
   click_button "Continue"
   expect(page).to have_content("Welcome to Pinterview")
 end

#  scenario "Login and then click profile page button" do
#    user = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
#    visit "/login"
#    fill_in "email", :with => user.email
#    fill_in "password", :with => user.password
#    click_button "Continue"    
#    click_button "My Profile"
#    expect(current_path).to eq users_show_path
#    expect(page).to have_content("Welcome to Profile Page")
#  end

#  scenario "Login and then click home page button" do
#    user = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
#    visit "/login"
#    fill_in "email", :with => user.email
#    fill_in "password", :with => user.password
#    click_button "Continue"    
#    click_button "Home"
#    expect(current_path).to eq root_path
#    expect(page).to have_content("Welcome to Pinterview")
#  end

#  scenario "create new pin after login" do
#    user = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
#    visit "/login"
#    fill_in "email", :with => user.email
#    fill_in "password", :with => user.password
#    click_button "Continue"
#    expect(current_path).to eq root_path

#    visit pins_new_path
#    pin = FactoryGirl.build_stubbed(:pin)
#    fill_in "position", with: pin.position
#    fill_in "company", with: pin.company
#    fill_in "date", with: pin.date
#    fill_in "difficulty", with: pin.difficulty
#    fill_in "type_interview", with: pin.type_interview
#    fill_in "attire", with: pin.attire
#    fill_in "questions", with: pin.questions
#    fill_in "length", with: pin.length
#    fill_in "description", with: pin.description
#    click_button "Create Now"     
    
#    expect(current_path).to eq root_path
#    expect(user.pins.count).to eq 1
#  end

#  scenario "valid login and logout" do
#    user = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
#    visit "/login"
#    fill_in "email", :with => user.email
#    fill_in "password", :with => user.password
#    click_button "Continue"
#    expect(page).to have_content("Welcome to Pinterview")

#    click_button 'Log out'
#    expect(current_path).to eq root_path
#  end

#  scenario "Display individual pin" do
#    user = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")    
#    visit "/login"
#    fill_in "email", :with => user.email
#    fill_in "password", :with => user.password
#    click_button "Continue"

#    visit pins_new_path
#    pin = FactoryGirl.build_stubbed(:pin)
#    fill_in "position", with: pin.position
#    fill_in "company", with: pin.company
#    fill_in "date", with: pin.date
#    fill_in "difficulty", with: pin.difficulty
#    fill_in "type_interview", with: pin.type_interview
#    fill_in "attire", with: pin.attire
#    fill_in "questions", with: pin.questions
#    fill_in "length", with: pin.length
#    fill_in "description", with: pin.description
#    click_button "Create Now" 

#    visit 'pins/1'    
#    expect(current_path).to eq pins_show_path  
#    expect(page).to eq have_content(pin.position)  
#  end

	private

  def login(email, password)
	   fill_in "Email", with: email
	   fill_in "Password", with: password
	   click_button "Log in"
  end
end
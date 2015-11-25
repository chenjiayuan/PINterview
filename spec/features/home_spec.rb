require "rails_helper"
require 'spec_helper'

feature "All Features Test" do
	scenario "check if it direct to new login page for hardlink to new pin path" do
    visit pins_new_path  
    expect(current_path).to eq "/login"
  end

	scenario("check if u can access new user link from home") do
    visit root_path
    click_link("Don't have an account?")
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

 scenario "unique email testing" do 
   user1 = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
   user2 = FactoryGirl.build_stubbed(:user, email: "ki.ey.kouch@berkeley.edu")
   visit "/signup"     
   fill_in "user_username", with: user2.username
   fill_in "user_password", with: user2.password
   fill_in "user_email", with: user2.email   
   click_button "Create an account"
   expect(current_path).to eq "/signup"
   expect(page).to have_content("Invalid Credential")
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
   expect(page).to have_content("Invalid Credential")
 end

 scenario "valid login" do
   user = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
   visit "/login"
   fill_in "session_email", :with => user.email
   fill_in "session_password", :with => user.password
   click_button "Continue"
   expect(page).to have_content("L O G O U T")
   expect(page).to have_content("Most Recent")
 end

 scenario "invalid login" do   
   visit "/login"
   fill_in "session_email", :with => Faker::Internet.email
   fill_in "session_password", :with => "123456"
   click_button "Continue"
   expect(page).to have_content("Invalid Credential")   
 end

 scenario "invalid login then valid" do   
   user = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
   visit "/login"
   fill_in "session_email", :with => user.email
   fill_in "session_password", :with => "12345"
   click_button "Continue"
   expect(page).to have_content("Invalid Credential") 
   fill_in "session_email", :with => user.email
   fill_in "session_password", :with => "123456"
   click_button "Continue"
   expect(page).to have_content("L O G O U T")
   expect(page).to have_content("Most Recent")  
 end

 scenario "login then click on profile" do
  user = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
  visit "/login"
  fill_in "session_email", :with => user.email
  fill_in "session_password", :with => user.password
  click_button "Continue" 
        
   expect(page).to have_content("Most Recent")
   click_link "P R O F I L E" 
   expect(page).to have_content(user.username)
   expect(page).to have_content(user.username)    
 end

  scenario "valid login and logout" do
   user = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
   visit "/login"
   fill_in "session_email", :with => user.email
   fill_in "session_password", :with => user.password
   click_button "Continue"
   expect(page).to have_content("Most Recent")

   click_link 'L O G O U T'
   expect(current_path).to eq "/login"
 end

 scenario "create new pin and edit" do 
   pin = FactoryGirl.build_stubbed(:pin)
   login    
   expect(page).to have_content("Most Recent")
   click_link "+ P I N" 
   expect(page).to have_content("Create a New Pin")
   
   fill_in "pin_position", :with => pin.position
   fill_in "pin_company", :with => pin.company
   fill_in "pin_date", :with => pin.date
   fill_in "pin_questions", :with => pin.questions
   fill_in "pin_description", :with => pin.description
   click_button "Submit"
   expect(page).to have_content(pin.description)

   # click edit
   click_button "Edit"
   fill_in "pin_questions", :with => "Hello Banana i love Banana"
   click_button "Submit"
   expect(page).to have_content("Hello Banana i love Banana")
 end

   scenario "create invalid pin" do    
    pin = FactoryGirl.build_stubbed(:pin)
    login       
    expect(page).to have_content("Most Recent")
    click_link "+ P I N" 
    expect(page).to have_content("Create a New Pin")
   
    fill_in "pin_position", :with => pin.position    
    fill_in "pin_date", :with => pin.date
    fill_in "pin_questions", :with => pin.questions
    fill_in "pin_description", :with => pin.description
    click_button "Submit"
    expect(page).to have_content("Invalid Input Type") 
   end

   scenario "user attempt to visit other user profile and get redirect to home page" do
    user1 = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
    user2 = FactoryGirl.create(:user, email: "ki.ey.kouch2@berkeley.edu")
    visit "/login"
    fill_in "session_email", :with => user1.email
    fill_in "session_password", :with => user1.password
    click_button "Continue"   
    click_link "P R O F I L E"     

    visit "/users/" + user2.id.to_s
    expect(current_path).to eq root_path
   end

   scenario "making pin favorite" do    
    pin = FactoryGirl.create(:pin)
    login    
    visit "/pins/" + pin.id.to_s
    click_button "Mark Helpful"
    expect(page).to have_button("Unmark Helpful") 
   end

   scenario "expect favorite in profile" do
    pin = FactoryGirl.create(:pin)
    login
    visit "/pins/" + pin.id.to_s
    click_button "Mark Helpful"
    click_link "P R O F I L E"
    expect(page).to have_content(pin.company) 
   end

 scenario "click on home" do    
    login
    click_link "H O M E"
    expect(current_path).to eq root_path
   end

   scenario "click on PINTERVIEW" do    
    login
    click_link "PINTERVIEW"
    expect(current_path).to eq root_path
   end

 #scenario "visit company page" do
  #  pin = FactoryGirl.create(:pin, company: "BLOOMBERG")
  #  login
  #  click_link "C O M P A N I E S"
  #  expect(current_path).to eq '/companies'
  #  page.find(".companybutton").click
  #  expect(page).to have_content(pin.company)
  # end

	private
  def login
    user = FactoryGirl.create(:user, email: "ki.ey.kouch@berkeley.edu")
    visit "/login"
    fill_in "session_email", :with => user.email
    fill_in "session_password", :with => user.password
    click_button "Continue" 
  end

end
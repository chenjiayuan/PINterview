require "rails_helper"

feature "visiting the home page" do
	scenario "check welcome text does it contains welcome" do
		visit root_path
		expect(page).to have_title "Welcome to PINterview"
	end

	scenario "check if can u access new user link from home" do         
      visit root_path
      visit users_new_path  
      expect(page).to have_title "Create New User"
    end

    scenario "check if can u access new pin link from home" do         
      visit root_path
      visit pins_new_path  
      expect(page).to have_title "Create New Pin"
    end

    scenario "create valid new user" do 
      user = FactoryGirl.build_stubbed(:user, email: "ki.ey.kouch@berkeley.edu")    
      visit root_path
      visit users_new_path      
      fill_in "username", with: user.username
      fill_in "password", with: user.password
      fill_in "email", with: user.email
      fill_in "grad_class", with: user.grad_class
      fill_in "major", with: user.major
      click_button "Sign up"     
      expect(page).to have_content "home"
    end

    scenario "invalid email new user" do
      user = FactoryGirl.build_stubbed(:user) 
      visit root_path
      visit users_new_path 
      
      fill_in "username", with: user.username
      fill_in "password", with: user.password
      fill_in "email", with: user.email
      fill_in "grad_class", with: user.grad_class
      fill_in "major", with: user.major
      click_button "Sign up"     

      expect(page).to have_error_message "Email is invalid"
    end

    scenario "create valid new pin" do  
      pin = FactoryGirl.build_stubbed(:pin)  
      visit root_path
      visit pins_new_path
      fill_in "title", with: pin.title
      fill_in "company", with: pin.company
      fill_in "date", with: pin.date
      fill_in "difficulty", with: pin.difficulty
      fill_in "type", with: pin.type
      fill_in "attire", with: pin.attire
      fill_in "questions", with: pin.questions
      fill_in "length", with: pin.length
      click_button "Submit"     
      expect(page).to have_content "home"
    end

	private

    def login(email, password)
	    fill_in "Email", with: email
	    fill_in "Password", with: password
	    click_button "Log in"
  	end

    
end
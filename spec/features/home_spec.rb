require "rails_helper"

feature "visiting the home page" do
	scenario "check welcome text does it contains welcome" do
		visit root_path
		expect(page).to have_text("dashboard")
	end

	it "attemp not routing" do
      {:get => "/widgets" }.should_not be_routable
    end

    it "routign to welcome" do
      {:get => "/welcome"}.should route_to(:controller => "static_pages", :action => "welcome")
    end

end
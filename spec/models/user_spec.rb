require 'spec_helper'

describe User do
  it "create valid user" do    
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu").should be_valid
  end

  it "invalid email" do    
    FactoryGirl.create(:user).should_not be_valid
  end
  
  it "duplicate email" do    
    email = "ki.ey.kouch@berkeley.edu"
  	FactoryGirl.create(:user, email: email)
  	FactoryGirl.build(:user, email: email).should_not be_valid
  end

  it "invalid empty password" do    
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu", password: "" ).should_not be_valid
  end

  it "invalid empty email" do    
    FactoryGirl.build(:user, email: "").should_not be_valid
  end

  it "invalid empty username" do    
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu", username: "").should_not be_valid
  end

  it "invalid empty grad_class" do    
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu", grad_class: "").should_not be_valid
  end

  it "invalid empty grad_class" do    
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu", major: "").should_not be_valid
  end

  it "invalid lenght username 40" do 
  	str = "a" * 40 
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu", username: str).should_not be_valid
  end

  it "invalid lenght password 40" do 
  	str = "a" * 40 
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu", password: str).should_not be_valid
  end

  it "invalid lenght grad_class 40" do    
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu", grad_class: "a" * 40).should_not be_valid
  end

  it "invalid lenght major 40" do    
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu", major: "a" * 40).should_not be_valid
  end



end
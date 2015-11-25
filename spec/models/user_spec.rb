# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  username            :string
#  email               :string
#  password_digest     :string
#  major               :string
#  grad_class          :string
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

require "rails_helper"
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

  it "invalid empty major" do    
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu", major: "").should_not be_valid
  end

  it "invalid lenght for username 51 char" do 
  	str = "a" * 31 
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu", username: str).should_not be_valid
  end

  it "invalid lenght for password less than 6 char" do 
  	str = "a"
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu", password: str).should_not be_valid
  end

  it "invalid lenght for grad_class 51 char" do    
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu", grad_class: "a" * 51).should_not be_valid
  end

  it "invalid lenght for major 51 char" do    
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu", major: "a" * 51).should_not be_valid
  end

  it "invalid user without major and grad_class" do    
    FactoryGirl.build(:user, email: "ki.ey.kouch@berkeley.edu", major: "", grad_class: "").should_not be_valid
  end

end

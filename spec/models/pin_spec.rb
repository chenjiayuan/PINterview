# == Schema Information
#
# Table name: pins
#
#  id             :integer          not null, primary key
#  position       :string
#  company        :string
#  date           :string
#  difficulty     :string
#  type_interview :string
#  attire         :string
#  questions      :string
#  like_count     :integer          default(0)
#  length         :string
#  description    :string
#  user_id        :integer
#  position_type  :string
#

require 'spec_helper'

describe "Pin" do

  it "create valid pin" do    
    expect(FactoryGirl.create(:pin)).to be_valid
  end  

  it "empty title" do    
    FactoryGirl.build(:pin, position: "" ).should_not be_valid
  end

  it "empty company" do    
    FactoryGirl.build(:pin, company: "" ).should_not be_valid
  end

  it "empty date" do    
    FactoryGirl.build(:pin, date: "" ).should_not be_valid
  end

  it "empty difficulty string" do    
    FactoryGirl.build(:pin, difficulty: "" ).should_not be_valid
  end
  
  it "empty type interview" do    
    FactoryGirl.build(:pin, type_interview: "" ).should_not be_valid
  end

  it "empty attire" do    
   FactoryGirl.build(:pin, attire: "" ).should_not be_valid
  end

  it "empty questions" do    
    FactoryGirl.build(:pin, questions: "" ).should_not be_valid
  end

  it "checking if like count is 0" do    
    user = FactoryGirl.create(:pin)
    user.like_count should == 0
  end

  it "length 41 title" do    
    FactoryGirl.build(:pin, position: "a"*41 ).should_not be_valid
  end

  it "company 41 title" do    
    FactoryGirl.build(:pin, company: "a"*41 ).should_not be_valid
  end

  it "length 40 date" do    
    FactoryGirl.build(:pin, date: "a"*41 ).should_not be_valid
  end
  
  it "length 10 type interview" do    
    FactoryGirl.build(:pin, type_interview: "a"*41 ).should_not be_valid
  end

  it "length 40 attire" do    
    FactoryGirl.build(:pin, attire: "a"*30 ).should_not be_valid
  end

  it "length 241 questions" do    
    FactoryGirl.build(:pin, questions: "a"*241 ).should_not be_valid
  end

  it "length 321 questions" do    
    FactoryGirl.build(:pin, description: "a"*321 ).should_not be_valid
  end

  it "difficulty lenght to much 31" do    
    FactoryGirl.build(:pin, difficulty: "a"*31 ).should_not be_valid
  end

  it "valid pin without description" do    
    FactoryGirl.build(:pin, description: "" ).should be_valid
  end  

  it "invalid pin without description and position" do    
    FactoryGirl.build(:pin, position: "", description: "" ).should_not be_valid
  end 

end


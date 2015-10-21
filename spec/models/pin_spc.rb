require 'spec_helper'

describe Pin do
  it "create valid pin" do    
    FactoryGirl.create(:pin).should be_valid
  end  

  it "empty title" do    
    FactoryGirl.build(:pin, title: "" ).should_not be_valid
  end

  it "empty company" do    
    FactoryGirl.build(:pin, company: "" ).should_not be_valid
  end

  it "empty date" do    
    FactoryGirl.build(:pin, date: "" ).should_not be_valid
  end

  it "negative difficulty" do    
    FactoryGirl.build(:pin, difficulty: -1 ).should_not be_valid
  end
  
  it "beyond 5 difficulty" do    
    FactoryGirl.build(:pin, difficulty: 5 ).should_not be_valid
  end

  it "empty type" do    
    FactoryGirl.build(:pin, type: "" ).should_not be_valid
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

  it "length 40 title" do    
    FactoryGirl.build(:pin, title: "a"*40 ).should_not be_valid
  end

  it "company 40 title" do    
    FactoryGirl.build(:pin, company: "a"*40 ).should_not be_valid
  end

  it "length 40 date" do    
    FactoryGirl.build(:pin, date: "a"*40 ).should_not be_valid
  end
  
  it "length 40 type" do    
    FactoryGirl.build(:pin, type: "a"*40 ).should_not be_valid
  end

  it "length 40 attire" do    
    FactoryGirl.build(:pin, attire: "a"*40 ).should_not be_valid
  end

  it "length 120 questions" do    
    FactoryGirl.build(:pin, questions: "a"*120 ).should_not be_valid
  end

  it "length 240 questions" do    
    FactoryGirl.build(:pin, description: "a"*240 ).should_not be_valid
  end

end
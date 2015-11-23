class CompaniesController < ApplicationController
  before_action :require_user, only: [:show, :edit]
  
  def show
	@pin = Pin.all
  end

  def update
  	@company = get_company(params[:category_id])
  end


  private
  def get_company(name)
    require 'csv'
    company = Hash.new
 
    CSV.foreach(File.join(Rails.root, 'app','csv','organizations.csv')) do |row|
      if row[0].downcase == name.downcase
        company['name'] = row[0]
        company['crunchbase'] = row[1]
        company['url'] = row[2]
        company['facebook'] = row[3]
        company['linkedin'] = row[4]
        company['city'] = row[5]
        company['state'] = row[6]
        company['description'] = row[7]

       else
       	company['name'] = name
        company['crunchbase'] = "" 
        company['url'] = ""
        company['facebook'] = ""
        company['linkedin'] = ""
        company['city'] = ""
        company['state'] = ""
        company['description'] = ""
      end
    end

    return company
  end

end
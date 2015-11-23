class CompaniesController < ApplicationController
  before_action :require_user, only: [:show, :edit]
  
  def show
	@pin = Pin.all
	@not_populated = ""

	if @pin.count == 0
		@not_populated = "There are currently no PINS or companies on PINTERVIEW, click +PIN to contribute!"
	end

  end

  def update

  	@not_populated = ""

  	if params[:category_id] !=nil
      @company = get_company(params[:category_id])
      @questions = Pin.where(company: params[:category_id])
      @company_name = @company['name']

      # EDGE CASE - Yahoo!
      if @company_name =='Yahoo!'
      	@company_name = 'Yahoo'
      end

    else
      @pin = Pin.all
      @not_populated = "There are currently no PINS or companies on PINTERVIEW, click +PIN to contribute!"
      render "show"
  	end  	
  end


  private
  def get_company(name)
    require 'csv'
    company = Hash.new

	# EDGE CASE - Yahoo!
    if name == 'Yahoo'
      name = 'Yahoo!'
    end

    company['name'] = name
    company['crunchbase'] = "" 
    company['url'] = ""
    company['facebook'] = ""
    company['linkedin'] = ""
    company['city'] = "Unknown"
    company['state'] = "Unknown"
    company['description'] = "We currently have no information about this company's online presence"
 
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
       	
      end
    end

    return company
  end

end


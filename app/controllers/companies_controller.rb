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

  	  # GET COMPANY INFO
      @company = get_company(params[:category_id])
      @questions = Pin.where(company: params[:category_id])
      @company_name = @company['name']

      # EDGE CASE - Yahoo!
      if @company_name =='Yahoo!'
      	@company_name = 'Yahoo'
      end

      # GET AVERAGE INTERVIEW TIME
  	  @length = get_average_time(params[:category_id])

  	  # GET MOST COMMON INTERVIEW MONTH
  	  @month = get_common_month(params[:category_id])

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

  private
  def get_average_time(company)

  	list_nums = []
  	all_lengths = Pin.where(company: company).pluck(:length)

  	all_lengths.each do |a_l|
	  if a_l == "Less Than 30 Min"
	  	list_nums.push(15)
	  end
	  if a_l == "30 Min"
	  	list_nums.push(30)
	  end
	  if a_l == "1 Hr"
	  	list_nums.push(60)
	  end
	  if a_l == "1.5 Hrs"
	  	list_nums.push(90)
	  end
	  if a_l == "2+ Hrs"
	  	list_nums.push(180)
	  end
  	end

  	average = list_nums.inject{ |sum, num| sum + num }.to_f / list_nums.size
  	return average
  end
  # "2 November, 2015"

  private
  def get_common_month(company)
  	new_dates = []
  	all_dates = Pin.where(company: company).pluck(:date)
  	all_dates.each do |date|

  		new_d = date.split(" ")[1].split(",")[0]
  		new_dates.push(new_d)

  	end

  	freq = new_dates.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
  	most_common_month = new_dates.max_by { |v| freq[v] }

  	return most_common_month

  end

end




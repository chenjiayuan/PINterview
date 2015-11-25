class CompaniesController < ApplicationController
  before_action :require_user, only: [:show, :edit]
  
  def show
  	@pin = Pin.all
    @random = @pin.pluck(:company).uniq.shuffle.first(5)
    
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

      # EDGE CASE - Yahoo!
      if @company_name =='Hewlett-Packard'
        @company_name = 'HP'
      end

      # GET AVERAGE INTERVIEW TIME
  	  @length = get_average_time(params[:category_id])

  	  # GET MOST COMMON INTERVIEW MONTH
  	  @month = get_common_month(params[:category_id])

  	  # GET PERCENTAGE NEXT ROUND
  	  @next_round = get_next_round(params[:category_id])

  	  # GET PERCENTAGE OFFERS
  	  @offers = get_offers(params[:category_id])

  	  # GET MOST COMMON POSITIONS
  	  @common_positions = get_common_positions(params[:category_id])

      @pin = Pin.where(company: params[:category_id])
      @calendar = [] 
      @pin.each do |p|
      @calendar.push({'title' => "#{p.type_interview}", 'start' => "#{p.date}", "allDay" => "1",
        "url" => pin_url(p)})
      end
      respond_to do |format|
        format.html {}
        format.json { render json:@calendar.to_json }
      end

    else
      @pin = Pin.all
      @not_populated = "There are currently no PINS or companies on PINTERVIEW, click +PIN to contribute!"
      render "show"
  	end 

  end

  # PRIVATE METHODS
  private
  def get_company(name)
    require 'csv'
    company = Hash.new

	  # EDGE CASE - Yahoo!
    if name == 'Yahoo'
      name = 'Yahoo!'
    end

    # EDGE CASE - HP
    if name == 'HP' or name == 'Hewlett Packard'
      name = 'Hewlett-Packard'
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

  private
  def get_next_round(company)
  	all_outcomes = Pin.where(company: company).pluck(:attire)
  	nexts = all_outcomes.count("Offer") + all_outcomes.count("Next Round")
  	rejects = all_outcomes.count - all_outcomes.count("Unknown")
  	percentage_next_round = (nexts/rejects) * 100
  	
  	return percentage_next_round
  end

  private
  def get_offers(company)
  	all_outcomes = Pin.where(company: company).pluck(:attire)
  	nexts = all_outcomes.count("Offer")
  	rejects = all_outcomes.count - all_outcomes.count("Unknown")
  	percentage_next_round = (nexts/rejects) * 100
  	
  	return percentage_next_round
  end

  private
  def get_common_positions(company)
  	most_common_positions = []
  	all_positions = Pin.where(company: company).pluck(:position)
  	freq = all_positions.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

  	most_common_positions = all_positions.uniq.sort_by{ |v| freq[v] }.reverse.first(5)
  	return most_common_positions
  end
end

class CompaniesController < ApplicationController
  before_action :require_user, only: [:show, :edit]
  
  def show
  	@pin = Pin.all
    @random = @pin.pluck(:company).uniq.shuffle.first(15)
    
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
      @company_number = @questions.count

      # EDGE CASE - Yahoo!
      if @company_name =='Yahoo!'
      	@company_name = 'Yahoo'
      end

      # EDGE CASE - Yahoo!
      if @company_name =='Hewlett-Packard'
        @company_name = 'HP'
      end

      @company_name = @company_name.downcase.delete(" ")

      # GET AVERAGE INTERVIEW TIME
  	  @length = get_average_time(params[:category_id])
      @pie = Pin.where(company: params[:category_id]).group(:length).count

      # GET AVERAGE INTERVIEW DIFFICULTY
      @difficulty = get_average_difficulty(params[:category_id])
      @pie_diff = Pin.where(company: params[:category_id]).group(:difficulty).count

  	  # GET MOST COMMON INTERVIEW MONTH
  	  @month = get_common_month(params[:category_id])
      @month1 = @month[0]
      @month2 = @month[1]

      # GET MOST COMMON INTERVIEW TYPE
      @type = get_common_type(params[:category_id])
      @type1 = @type[0]
      @type2 = @type[1]

      # GET MOST COMMON GENRE
      @genre = get_common_genre(params[:category_id])
      @genre1 = @genre[0]
      @genre2 = @genre[1]

  	  # GET PERCENTAGE NEXT ROUND
  	  @next_round = get_next_round(params[:category_id])

  	  # GET PERCENTAGE OFFERS
  	  @offers = get_offers(params[:category_id])

      # PIE CHART FOR RESULTS
      @pie_results = Pin.where(company: params[:category_id]).group(:attire).count

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
    company['city'] = "City Unknown"
    company['state'] = "State Unknown"
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
  	return average.round
  end

  private
  def get_average_difficulty(company)

    list_nums = []
    all_lengths = Pin.where(company: company).pluck(:difficulty)

    all_lengths.each do |a_l|
    if a_l == "0 - Very Easy"
      list_nums.push(0)
    end
    if a_l == "1 - Easy"
      list_nums.push(1)
    end
    if a_l == "2 - Medium"
      list_nums.push(2)
    end
    if a_l == "3 - Hard"
      list_nums.push(3)
    end
    if a_l == "4 - Very Hard"
      list_nums.push(4)
    end
    end

    average = list_nums.inject{ |sum, num| sum + num }.to_f / list_nums.size
    return average.round(2)
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
    ret = [freq, most_common_month]
  	return ret
  end

  private
  def get_common_type(company)
    new_types = []
    all_types = Pin.where(company: company).pluck(:type_interview)
    freq = all_types.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    most_common_type = all_types.max_by { |v| freq[v] }
    ret = [freq, most_common_type]
    return ret
  end

  private
  def get_next_round(company)
  	all_outcomes = Pin.where(company: company).pluck(:attire)
  	nexts = all_outcomes.count("Offer") + all_outcomes.count("Next Round")
  	rejects = all_outcomes.count
      if rejects == 0
        return 0
      end
  	percentage_next_round = ((nexts.to_f/rejects.to_f) * 100).round

    temp = [all_outcomes, nexts, rejects, percentage_next_round]
  	
  	return percentage_next_round
  end

  private
  def get_offers(company)
  	all_outcomes = Pin.where(company: company).pluck(:attire)
  	nexts = all_outcomes.count("Offer")
  	rejects = all_outcomes.count
      if rejects == 0
        return 0
      end
  	percentage_next_round = ((nexts.to_f/rejects.to_f) * 100).round
  	
    temp = [all_outcomes, nexts, rejects, percentage_next_round]

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

private
  def get_common_genre(company)

    all_genres = Pin.where(company: company).pluck(:genre)
    freq = all_genres.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    most_common_genre = all_genres.max_by { |v| freq[v] }
    ret = [freq, most_common_genre]
    return ret
  end

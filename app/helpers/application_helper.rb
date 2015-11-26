module ApplicationHelper
  def get_company_url(company)
    "#{root_url}/companies/company?utf8=✓&category_id=#{company}&commit=Go+To+Company+Page"
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: "CJYseed", password: "111111", email: "1@berkeley.edu",
  grad_class: "2016", major: "EECS")


companies = ['Google','Yahoo','Uber','Oracle','Amazon',
  'Airbnb','Twitter','Microsoft','HP','IBM','Costco','Github',
  'Pivotal','Linkedin','Apple','Quora','Pinterest','Zazzle','Gusto', 
  'Qualcomm','EMC','Xerox','eBay','Paypal','Bloomberg','NetApp','Symantec','SanDisk',
  'Samsung','Sony','Panasonic','Dell']

year = ', 2015'
month = ["September", "October", "November", "December"]
days = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
difficulties = ['0 - Very Easy', '1 - Easy', "2 - Medium", "3 - Hard", "4 - Very Hard"]
types = ['On Site', 'On Campus', 'Phone', 'Online Assessment']
attirs = ['Offer','Offer','Offer','Offer','Offer','Offer', 'Rejected','Rejected', 
  'Next Round','Next Round','Next Round','Next Round', 'Unknown']

positions = ['Consultant','Software Developer','Tester','Product Manager', 'QA Engineer', 'UI designer']
position_types = ['Full-time', 'Full-time', 'Full-time', 'Full-time', 'Part-time', 'Internship']

100.times { |i|
Pin.create(position: positions.sample, company: companies.sample, date: days.sample.to_s + ' ' + month.sample + year,
	difficulty: difficulties.sample, type_interview: types.sample, attire: attirs.sample, 
	questions: "How to make string double its size", like_count: 0, 
	length: "30 Min", description: "I found the bug!", user_id: 1, position_type: position_types.sample)
}

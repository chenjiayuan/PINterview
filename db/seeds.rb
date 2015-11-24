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
  'Qualcomm','EMC','Xerox','eBay','Paypal','Texas Instruments','NetApp','Symantec','SanDisk',
  'Samsung','Sony','Panasonic','Dell']

year = ', 2015'
month = ["September", "October", "November", "December"]
days = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]

# dates = ['24 November, 2015', '15 November, 2015', '20 November, 2015', '21 October, 2015',
# 	'27 October, 2015', '2 October, 2015','5 October, 2015','14 October, 2015',
# 	'3 September, 2015', '4 September, 2015','5 September, 2015','6 September, 2015', '15 September, 2015',
# 	'4 August, 2015', '10 August, 2015', '15 August, 2015', '21 August, 2015', '26 August, 2015']

positions = ['CEO','CFO','COO','Software Developer','Tester','Manager','Mechanician']

1000.times { |i|
Pin.create(position: positions.sample, company: companies.sample, date: days.sample.to_s + ' ' + month.sample + year,
	difficulty: "Easy", type_interview: "Technical", attire: "Onsite", 
	questions: "How to make string double its size",like_count: 0, 
	length: "30 Min", description: "I found the bug!", user_id: 1, position_type: "full-time")
}
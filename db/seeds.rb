# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a1 = Pin.create(position: "Software", company: "Yahoo", date: "10/20/2015",
	difficulty: "Easy", type_interview: "Technical", attire: "Yes", 
	questions: "How to make string double its size",like_count: 0, 
	length: "30 Minutes", description: "I found the bug!")

#a2 = User.create(username: "Kiey", password: "John", email: "ki.ey.kouch@berkeley.edu",
#	grad_class: "2016", major: "Computer Science")
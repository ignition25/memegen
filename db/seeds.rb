# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
templates = Template.create([{ title: 'Overachiever', path: '1bhz.jpg' }, 
	{ title: 'Grumpy Cat', path: '8p0a.jpg' }, 
	{ title: 'Spiderman Doing Nothing', path: 'tas1.jpg' }, 
	{ title: 'Suit Cat', path: '1bh7.jpg' },
	{ title: 'Most Interesting Man', path: '1bh8.jpg'},
	{ title: 'Patriotic', path: '2pte.jpg' },
	{ title: 'Realization Guy', path: '25w4.jpg' },
	{ title: 'Picard Upset', path: '59qi.jpg' },
	{ title: 'Picard Facepalm', path: 'wczz.jpg'}
	])
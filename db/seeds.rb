# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Seeding templates..."
templates = Template.create([{ title: 'Overachiever', path: '1bhz.jpg' }, 
	{ title: 'Grumpy Cat', path: '8p0a.jpg' }, 
	{ title: 'Spiderman Doing Nothing', path: 'tas1.jpg' }, 
	{ title: 'Suit Cat', path: '1bh7.jpg' },
	{ title: 'Most Interesting Man', path: '1bh8.jpg'},
	{ title: 'Patriotic', path: '2pte.jpg' },
	{ title: 'Realization Guy', path: '25w4.jpg' },
	{ title: 'Picard Upset', path: '59qi.jpg' },
	{ title: 'Picard Facepalm', path: 'wczz.jpg'},
	{ title: 'Cocaine Bear', path: 'cocaine-bear.jpg'},
	{ title: 'Science Cat', path: '1bif.jpg' },
	{ title: 'First World Problems', path: '1bhf.jpg' },
	{ title: 'Futurama Fry', path: '1bgw.jpg' },
	{ title: 'Morpheus', path: '25w3.jpg'},
	{ title: 'Yo Dawg Heard You', path: '26hg.jpg'},
	{ title: 'Super Cool Ski Instructor', path: '25w7.jpg'},
	{ title: 'Aaaaand Its Gone', path: 'gft6.jpg'},
	{ title: 'Brace Yourselves X is Coming', path: '1bhm.jpg' },
	{ title: 'Scumbag Steve', path: '1bgy.jpg' },
	{ title: 'Socially Awesome Awkward Penguin', path: '1bio.jpg' },
	{ title: 'Cool Obama', path: '3524.jpg' },
	{ title: 'Kevin Hart The Hell', path: '5p31.jpg' },
	{ title: 'Hide Yo Kids Hide Yo Wife', path: 'g2xy.jpg' },
	{ title: 'Rebecca Black', path: '26fy.jpg' },
	{ title: 'Advice Dog', path: '1bh2.jpg' },
	{ title: 'Grumpy Cat Top Hat', path: 'oprs.jpg' },
	{ title: 'Computer Horse', path: 'c153.jpg' },
	{ title: 'The Rent is Too Damn High', path: 'b71.jpg' },
	{ title: 'Success Kid', path: 'success-kid-on-beach-meme-template.jpg' },
	{ title: 'Condescending Wonka', path: 'condescending-willy-wonka-meme-template.jpg' },
	{ title: 'Evil Toddler', path: 'evil-toddler-meme-template.jpg' },
	{ title: 'History Channel Aliens', path: 'history-channel-aliens-meme-template.jpg' },
	{ title: 'Overly Attached Girlfriend', path: 'overly-attached-girlfriend-meme-template.jpg' }
	])

# Load next seed file.
load "#{Rails.root}/db/seeds2.rb"
load "#{Rails.root}/db/seeds3.rb"

puts "Seeding complete."
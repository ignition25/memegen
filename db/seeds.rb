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

templates2 = Template.create([{ title: 'Philosoraptor', path: '1bgs.jpg' },
	{ title: 'Unhelpful Teacher', path: '25wd.jpg' },
	{ title: 'And Then We Said', path: 'jrj7.jpg' },
	{ title: 'Put It Somewhere Else Patrick', path: '1bil.jpg' },
	{ title: 'Say That Again I Dare You', path: '2nuc.jpg' },
	{ title: 'One Does Not Simply', path: '1bij.jpg' },
	{ title: 'X All The Y', path: '1bh9.jpg' },
	{ title: 'Am I The Only One Around Here', path: '5kdc.jpg' },
	{ title: 'Confession Bear', path: '25wb.jpg' },
	{ title: 'Joseph Ducreux', path: '1bhb.jpg' },
	{ title: 'Insanity Wolf', path: '1bgu.jpg' },
	{ title: 'I Should Buy A Boat Cat', path: 'tau4.jpg' },
	{ title: 'Chuck Norris Approves', path: '566w.jpg' },
	{ title: 'What Really Grinds My Gears', path: '7n5z.jpg' },
	{ title: 'Ghetto Robe Guy', path: '18gg.jpg' },
	{ title: 'No Patrick', path: 'nopatrick.jpg' },
	{ title: 'WTF Jacky Chan', path: 'wtfjackychan.jpg' },
	{ title: 'Upvote Obama', path: '685.png' },
	{ title: 'Cash Catz', path: '11b.jpg' },
	{ title: 'Get Out of the Way', path: 'catdriving1.jpg' }])

templates3 = Template.create([{ title: 'Do This They Said', path: '4e7.jpeg' },
	{ title: 'Ryan Frank', path: 'ryanfrank.jpg' },
	{ title: 'Chad Butler Bitches', path: 'chad.jpg'}])

templates4 = Template.create([{ title: 'Third World Success Kid', path: '265j.jpg' },
	{ title: 'Bad Luck Brian', path: '1bip.jpg' },
	{ title: 'Third World Skeptical Kid', path: '265k.jpg'},
	{ title: 'Batman Slapping Robin', path: '9ehk.jpg'},
	{ title: 'That Would Be Great', path: 'c2qn.jpg'},
	{ title: 'Yao Ming', path: '2c47.jpg'},
	{ title: "Didn't You Squidward", path: '26br.jpg'},
	{ title: 'Drunk Baby', path: '25w0.jpg'},
	{ title: 'Dwight Schrute', path: '1bhu.jpg'},
	{ title: 'Baby Godfather', path: '26h4.jpg'},
	{ title: 'Bear Grylls (Better Drink My Own Piss)', path: '1bho.jpg'},
	{ title: 'Impossibru Guy', path: '6l71.jpg'},
	{ title: 'Advice Mallard', path: 't2sg.jpg'},
	{ title: 'Lazy College Senior', path: '26a2.jpg'},
	{ title: 'Ron Burgundy', path: 'qeqb.jpg'},
	{ title: 'Most Interesting Cat In The World', path: '1bic.jpg'},
	{ title: 'Bad Luck Bear', path: '5wnr.jpg'},
	{ title: 'Friend Zone Fiona', path: '264v.jpg'},
	{ title: 'Stoner Dog', path: 'stoner-dog-meme-template.jpg'},
	{ title: 'College Freshman', path: '2543c.jpg'}
	]);

puts "Seeding complete."
extends Label

var my_visible_characters = 0.1
var limit = 0

export (float) var speed = .3
export (int) var time_between = 1
var my_phrase = 1
var max_phrases = 3
var waiting = false
var done = false

func text_crawl():
	if my_visible_characters <= limit:
		my_visible_characters+= speed
		self.visible_characters = self.my_visible_characters
	else:
		if (self.waiting == false) and (self.done == false):
			$Timer.start(time_between)
			self.waiting = true


func _ready():
	$Timer.start(.1)


func _process(delta):
	self.text_crawl()



func _on_Timer_timeout():
	waiting = false
	
	
	if my_phrase == 1:
		self.my_visible_characters = 0
		self.limit = 230
		self.set_text(
			"In an age since forgotten, the Queen of Faeries fell in love with the second king of hell, King Paimon. \nAlthough their love is forbidden, the Queen vowed to send her lover offerings from the human plane."
		)
	
	
	if my_phrase == 2:
		self.my_visible_characters = 0
		self.limit = 290
		self.set_text(
			"Every seven years, the Faerie Queen selects her favorite out of all the humans and sends their soul to hell. \n She expects that after enduring seven circles of sinful corruption, Paimon will be met with a soul so vile \nthat it must have been sent by his long lost love. And thus, Paimon and the Faerie Queen are together in thought."
		)
	
	if my_phrase == 3:
		self.my_visible_characters = 0
		self.limit = 355
		self.set_text(
			"To escape eternal punishments at the hands of the crowned king, one must be able to resist the temptations\n of sin as they progress through hell. Paimon would have no choice but to send the tormented\n soul back through to the surface realm, freeing you from the grips of hell. Of course, the Queen Faerie\n isn’t gonna make things easy for you. Good luck!"
		)
	
	if my_phrase == self.max_phrases:
		self.done = true
	
	self.my_phrase += 1
	$Timer.stop()

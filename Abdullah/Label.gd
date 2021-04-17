extends Label

var my_visible_characters = 0.1
var limit = 0

var my_phrase = 1
var max_phrases = 2
var waiting = false
var done = false

func text_crawl():
	if my_visible_characters <= limit:
		my_visible_characters+= .5
		self.visible_characters = self.my_visible_characters
	else:
		if (self.waiting == false) and (self.done == false):
			print("hey")
			$Timer.start(3)
			self.waiting = true


func _ready():
	pass


func _process(delta):
	self.text_crawl()



func _on_Timer_timeout():
	waiting = false
	print("bruh")
	
	
	if my_phrase == 1:
		self.my_visible_characters = 0
		self.limit = 230
		self.set_text("In an age since forgotten, the Queen of Faeries fell in love with the second king of hell, King Paimon. \nAlthough their love is forbidden, the Queen vowed to send her lover offerings from the human plane.")
	
	
	if my_phrase == 2:
		self.my_visible_characters = 0
		self.limit = 290
		self.set_text("Every seven years, the Faerie Queen selects her favorite out of all the humans and sends their soul to hell. \n She expects that after enduring seven circles of sinful corruption, Paimon will be met with a soul so vile \nthat it must have been sent by his long lost love. And thus, Paimon and the Faerie Queen are together in thought.")
	
	if my_phrase == self.max_phrases:
		self.done = true
	
	self.my_phrase += 1
	$Timer.stop()

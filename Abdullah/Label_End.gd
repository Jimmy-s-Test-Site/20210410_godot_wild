extends Label

signal goto_next

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
		self.limit = 223
		self.set_text(
			"You’ve done it! Against all odds, you were able to purify your soul. \nPaimon has never met such an immaculate heart in such a deep circle of hell. \nIt must have been a mistake! The Faerie Queen would never have allowed this."
		)
	
	
	if my_phrase == 2:
		self.my_visible_characters = 0
		self.limit = 114
		$ColorRect2.visible = true
		self.set_text(
			"The door of Hell is open now. You are sent back to the surface world, where you’re free from the banes of hell"
		)
	
	if my_phrase == 3:
		self.my_visible_characters = 0
		self.limit = 64
		self.set_text(
			"You just gotta pray you don’t get picked again in seven years."
		)
		$Button.visible = true
		$Button2.visible = true
	
	if my_phrase == self.max_phrases:
		self.done = true
	
	self.my_phrase += 1
	$Timer.stop()

extends Control

var letter_index = 0
var text = null

#Modify "letter_time" to change how fast each individual letter appears
@export var letter_time = 0.03

@onready var label = $MarginContainer/Panel/MarginContainer/Text
@onready var timer = $Timer
@onready var display_name = $MarginContainer/Panel/Name

func _ready():
	_character_select()
	_display_name()
	_display_text()

func _physics_process(_delta):
	if Input.is_action_just_pressed("Interact"):
		label.set_text("")
		Global.index += 1
		letter_index = 0
		_display_text()

#Changes the text of the Label "Name"
func _display_name():
	display_name.text = text[0]

#Changes the text of the Label "Text"
#"Z" to go to the next text, "X" to force it to the final letter index
func _display_text():
	if Global.index < text.size():
		var current_text = text[Global.index]
		if letter_index < current_text.length():
			label.text += current_text[letter_index]
			match current_text[letter_index]:
				_:
					timer.start(letter_time)
			letter_index += 1
		if Input.is_action_just_pressed("Force"):
			label.set_text(text[Global.index])
			letter_index = current_text.length()
			return
		else:
			return
	else:
		return

func _on_timer_timeout():
	_display_text()

#Calls which dialog set to use from Dialog.gd
#Add more if you want to call more sets in the format of "Dialog.set_name"
func _character_select():
	if Global.character == 0:
		text = Dialog.text_1

func _change_choices():
	pass

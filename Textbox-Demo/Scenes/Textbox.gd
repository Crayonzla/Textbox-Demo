extends Control

var read_rate = 0.5
var letter_index = 0

var text

@export var letter_time = 0.03

@onready var label = $MarginContainer/Panel/MarginContainer/Label
@onready var timer = $Timer


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

func _display_name():
	$MarginContainer/Panel/Name.text = text[0]

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

func _character_select():
	if Global.character == 0:
		text = Dialog.text_1

func _change_choices():
	pass

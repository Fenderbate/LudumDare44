extends Node

var text = [
# 0
"This is the solar system screen. To move around, hold down the middle or right mouse button and move the mouse!",
# 1
"Use the mouse scroll wheel to zoom in/out!",
# 2
"In order to pay the aliens and comquer Humpa, you have to collect living creatures.",
# 3
"You can collect lifeforms from the planets, but you have to take over them first.",
# 4
"Let's take over the small red planet! Click on it and press RAID!",
# 5
"RAIDing takes 5 lives per second.\nOptionally, you can cancel the RAID using the STOP button",
# 6
"RAIDing is done by your ships. They are those small purple dots on the screen.\nThey're spawned by the robot base.",
# 6.5
"After you conquered a planet, the RAID button will turn into CLAIM.\n a RAID is complete when the targeted planet's RESISTANCE drops to 0",
# 7
"Pressing the CLAIM button, you can collect half of the current life on the planet.",
# 8
"Don't collect all of them, because the planet won't repopulate!",
# 9
"On the top left, you can see how many lives you've got, how much you have to pay and how much time you have.",
# 10
"If you don't pay before the time runs out, you lose!",
# 11
"Your mission is to take over Humpa - the planet, second closest to the solar system's star",
# 12
"Your training is complete! Click once again to hide this manual."
]

var text_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$C/Info.text = text[text_index]
	

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			text_index += 1
			if text_index == text.size():
				queue_free()
				return
			$C/Info.text = text[text_index]
			
func _on_Tutorial_tree_exiting():
	get_parent().get_node("Utility/PaymentTimer").start()


func _on_Skip_button_down():
	queue_free()

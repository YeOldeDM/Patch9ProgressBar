extends EditorPlugin
tool

const PATH = 'res://addons/Patch9ProgressBar/'

func _enter_tree():
	add_custom_type("Patch9ProgressBar", "Range", load(PATH+'progressbar.gd'), load(PATH+'progressbar.png'))

func _exit_tree():
	remove_custom_type("Patch9ProgressBar")
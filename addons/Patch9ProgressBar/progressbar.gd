
extends Range
tool

var under_patch = Patch9Frame.new()
var over_patch = Patch9Frame.new()
var progress_patch = Patch9Frame.new()
var display_text = Label.new()

export(int, "None", "Percent", "Amount") var display_info setget _set_display_info
export(Font) var display_info_font


export(Texture) var under_image setget _set_under_image
export var under_patch_margin = IntArray([0,0,0,0]) setget _set_under_patch_margin

export(Texture) var over_image setget _set_over_image
export var over_patch_margin = IntArray([0,0,0,0]) setget _set_over_patch_margin

export(Texture) var progress_image setget _set_progress_image
export var progress_patch_margin = IntArray([0,0,0,0]) setget _set_progress_patch_margin



func _set_display_info(value):
	display_info = value
	_draw_display_text()
	
func _set_under_image(image):
	under_image = image
	under_patch.set_texture(image)

func _set_over_image(image):
	over_image = image
	over_patch.set_texture(over_image)

func _set_progress_image(image):
	progress_image = image
	progress_patch.set_texture(progress_image)

func _set_under_patch_margin(value):
	under_patch_margin = value
	for i in range(4):
		under_patch.set_patch_margin(i, value[i])

func _set_over_patch_margin(value):
	over_patch_margin = value
	for i in range(4):
		over_patch.set_patch_margin(i, value[i])

func _set_progress_patch_margin(value):
	progress_patch_margin = value
	for i in range(4):
		progress_patch.set_patch_margin(i, value[i])

func _set_progress_size():
	var size = get_size()
	var per = _get_percent()
	var x = lerp(0, size.x, per)
	size.x = x
	progress_patch.set_size(size)

func _get_percent():
	return (get_value()*1.0) / ((get_max()-get_min())*1.0)

func _draw_display_text():
	var txt = ""
	if display_info == 1:
		txt = str(int(_get_percent()*10))+"%"
	elif display_info == 2:
		txt = str(int(get_value()))+"/"+str(int(get_max()))
	display_text.set_text(txt)

func _enter_tree():
	add_child(under_patch)
	add_child(progress_patch)
	add_child(over_patch)
	add_child(display_text)
	
	under_patch.set_size(get_size())
	_set_progress_size()
	over_patch.set_size(get_size())
	display_text.set_size(get_size())
	display_text.set_align(Label.ALIGN_CENTER)
	display_text.set_valign(Label.VALIGN_CENTER)
	_draw_display_text()
	
	connect("item_rect_changed", self, "_item_rect_changed")
	connect("value_changed", self, "_on_value_changed")
	connect("changed", self, "_on_changed")

func _on_value_changed(value):
	_set_progress_size()

func _on_changed():
	_set_progress_size()

func _item_rect_changed():
	under_patch.set_size(get_size())
	_set_progress_size()
	over_patch.set_size(get_size())
	display_text.set_size(get_size())

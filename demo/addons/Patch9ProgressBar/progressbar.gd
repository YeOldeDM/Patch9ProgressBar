
extends Range
tool

# Constants
const DISPLAY_NONE = 0
const DISPLAY_PERCENT = 1
const DISPLAY_AMOUNT = 2

const ALIGN_LEFT = 0
const ALIGN_RIGHT = 1
const ALIGN_CENTER = 2

const DIRECTION_HORIZONTAL = 0
const DIRECTION_VERTICAL = 1

# Child nodes
var under_patch = Patch9Frame.new()
var over_patch = Patch9Frame.new()
var progress_patch = Patch9Frame.new()
var display_text = Label.new()

# DISPLAY TEXT PARAMS

# Display Text Settings
export(int, "None", "Percent", "Amount") var display_info setget _set_display_info

# Display Text Font
export(Font) var display_info_font

# Display Font Color
export(Color) var font_color setget _set_font_color


# PROGRESS BAR PARAMS

# Progress Bar Alignment
export(int, "Left/Bottom", "Right/Top", "Center") var progress_bar_alignment setget _set_progress_bar_alignment

# Progress Bar Direction
export(int, "Horizontal", "Vertical") var progress_bar_direction setget _set_progress_bar_direction



# PATCH9 PARAMS

# Under Patch9 image
export(Texture) var under_image setget _set_under_image
# Under Patch9 margins
export var under_patch_margin = IntArray([0,0,0,0]) setget _set_under_patch_margin

# Over Patch9 image
export(Texture) var over_image setget _set_over_image
# Over Patch9 margins
export var over_patch_margin = IntArray([0,0,0,0]) setget _set_over_patch_margin

# Progress Patch9 image
export(Texture) var progress_image setget _set_progress_image
# Progress Patch9 margins
export var progress_patch_margin = IntArray([0,0,0,0]) setget _set_progress_patch_margin



func _set_display_info(value):
	display_info = value
	_draw_display_text()

func _set_font_color(color):
	font_color = color
	display_text.set('custom_colors/font_color', color)

func _set_progress_bar_alignment(id):
	progress_bar_alignment = id
	_set_progress_size()

func _set_progress_bar_direction(id):
	progress_bar_direction = id
	_set_progress_size()

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
	var pos = Vector2(0,0)
	var size = get_size()
	var per = _get_percent()
	var x = lerp(0, size.x, per)
	size.x = x
	
	if progress_bar_alignment == ALIGN_LEFT:
		progress_patch.set_pos(pos)
		progress_patch.set_size(size)
	
	if progress_bar_alignment == ALIGN_RIGHT:
		pos.x += x
		var prog_pos = (get_size()-size)
		prog_pos.x = min(prog_pos.x, get_size().x - (progress_patch_margin[0]+progress_patch_margin[2]))
		progress_patch.set_pos(prog_pos)
		progress_patch.set_size(size)
	
	if progress_bar_alignment == ALIGN_CENTER:
		progress_patch.set_size(size)
		pos.x = (get_size().x / 2) - (size.x/2)
		pos.x = min(pos.x, (get_size().x/2) - progress_patch_margin[0])
		progress_patch.set_pos(pos)

	_draw_display_text()


func _get_percent():
	return (get_value()*1.0) / ((get_max()-get_min())*1.0)

func _draw_display_text():
	var txt = ""
	if display_info == DISPLAY_PERCENT:
		txt = str(int(_get_percent()*100))+"%"
	elif display_info == DISPLAY_AMOUNT:
		txt = str(int(get_value()))+"/"+str(int(get_max()))
	display_text.set_text(txt)



# Init
func _enter_tree():
	add_child(under_patch)
	under_patch.add_child(progress_patch)
	under_patch.add_child(over_patch)
	under_patch.add_child(display_text)
	
	under_patch.set_size(get_size())
	_set_progress_size()
	over_patch.set_size(get_size())
	display_text.set_size(get_size())
	display_text.set_align(Label.ALIGN_CENTER)
	display_text.set_valign(Label.VALIGN_CENTER)
	_draw_display_text()
	
	connect("item_rect_changed", self, "_item_rect_changed")
	connect("value_changed", self, "_value_changed")
	connect("changed", self, "_changed")



# Signals
func _value_changed(value):
	_set_progress_size()

func _changed():
	_set_progress_size()

func _item_rect_changed():
	under_patch.set_size(get_size())
	_set_progress_size()
	over_patch.set_size(get_size())
	display_text.set_size(get_size())

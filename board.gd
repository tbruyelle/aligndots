extends Node2D

var grid: Array = [
	1,1,1,2,0,0,
	1,1,1,1,0,0,
	1,1,1,1,1,1,
	3,1,1,1,1,3,
	1,1,1,2,1,1,
	1,1,1,1,1,1,
]

var selected=-1

var cells: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func found_cell_idx(pt):
	for i in range(len(cells)):
		if Rect2(cells[i]).has_point(pt):
			return i
	return -1

	
func _input(event):	
	if Input.is_action_just_released("press"):
		print("RELEASED")
		selected=-1
	if Input.is_action_pressed("press"):		
		var i = found_cell_idx(event.position)
		if i == -1:
			selected=-1
			return
		print("PRESS",i," sel=",selected)
		if selected==-1:
			if grid[i]>1:
				# There's a dot at this position, select it
				selected=i
		else:
			if grid[i]==1:
				#swap position
				grid[i]=grid[selected]
				grid[selected]=1
				selected=i
	queue_redraw()							
	
func _draw():
	var scr = get_viewport().size
	var cell_size=scr/6
	var half_cell_size=cell_size/2
	var mindim = min(half_cell_size.x, half_cell_size.y)
	cells=[]
	for i in range(len(grid)):
		var pos = Vector2i(i%6,i/6)
		var scr_pos=pos*cell_size
		var radius=mindim/1.6
		if selected==i:
			radius=radius*1.4
		var cell=Rect2(scr_pos,cell_size)
		cells.append(cell)
		if grid[i]>0:
			draw_rect(cell,Color.BLANCHED_ALMOND, false, 3)
		if grid[i]==2:						
			draw_circle(scr_pos+half_cell_size, radius, Color.RED)
		if grid[i]==3:
			draw_circle(scr_pos+half_cell_size, radius, Color.BLUE)
#	if selected!=-1:		
#		var x = selected%6*width
#		var y = selected/6*height
#		draw_rect(Rect2(x,y,width,height ),Color.WEB_PURPLE, false, 3)

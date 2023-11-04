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

var rects: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func found_cell_idx(pt):
	for i in range(len(rects)):
		if Rect2(rects[i]).has_point(pt):
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
	var width=scr.x/6
	var height=scr.y/6
	var midwidth=width/2
	var midheight=height/2
	var mindim=min(midheight, midwidth)	
	rects=[]
	for i in range(len(grid)):
		var x = i%6*width
		var y = i/6*height
		var radius=mindim/2
		if selected==i:
				radius=radius*1.2
		rects.append(Rect2(x,y,width,height))		
		if grid[i]>0:		
			draw_rect(Rect2(x,y,width,height ),Color.BLANCHED_ALMOND, false, 3)
		if grid[i]==2:						
			draw_circle(Vector2(x+midwidth,y+midheight), radius, Color.RED)
		if grid[i]==3:
			draw_circle(Vector2(x+midwidth,y+midheight), radius, Color.BLUE)
#	if selected!=-1:		
#		var x = selected%6*width
#		var y = selected/6*height
#		draw_rect(Rect2(x,y,width,height ),Color.WEB_PURPLE, false, 3)

extends Control

var vertices=[]
var elements=[]

enum ELEMENT_TYPE {Line=3,
	Triangle=5,
	Quadrilateral=9,
	Tetrahedral=10
	Hexahedral=12
	Prism=13
	Pyramid=14
}

func pack(x,y,size):
	return x*size+y

func _ready():
	gen_mesh(4)
	
func gen_mesh(size):
	vertices=[]
	elements=[]
	for i_x in range(size):
		for i_y in range(size):
			var pos=Vector2(i_x*50.0,i_y*50.0)+Vector2(100.0,100.0)
			assert(pack(i_x,i_y,size)==vertices.size()) #test if element is going to be appended with predictable id
			vertices.append(pos)
	for i_x in range(size-1):
		for i_y in range(size-1):
			var element=[ELEMENT_TYPE.Quadrilateral,pack(i_x,i_y,size),pack(i_x+1,i_y,size),
													pack(i_x+1,i_y+1,size),pack(i_x,i_y+1,size)]
			elements.append(element)

func _draw_example():
	draw_polygon(PoolVector2Array([Vector2(100.0,100.0),
									Vector2(200.0,100.0),
									Vector2(150.0,200.0),
								]),PoolColorArray([
									Color.red,
									Color.red,
									Color.black,
								]))

#we use cached random color for drawing
func cached(cache:Dictionary,id,value):
	if id in cache.keys():
		return cache[id]
	else:
		cache[id]=value
		return value

var id_2color={}
func _draw():
	for e_id in range(elements.size()):
		var e=elements[e_id]
		if e[0]==ELEMENT_TYPE.Quadrilateral:
			var color=cached(id_2color,e_id,Color(randf(),randf(),randf()))
			draw_polygon(PoolVector2Array([vertices[e[1]],
					vertices[e[2]],
					vertices[e[3]],
					vertices[e[4]],
						]),
						PoolColorArray([
							color,
							color,
							color,
							color,
						])
			)
			



func _on_Button_pressed():
	gen_mesh($"../setings/SpinBox".value)
	update()

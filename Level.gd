extends Node2D

var adj = {}
var destination = 99 
var start = 91
var clicked_nodes = []
var available_nodes = []
var position_array = []

var moves_left = 6

var total_clicked_sum = 0

onready var start_box = get_node("Start")
onready var finish_box = get_node("Finish")

onready var node1 = get_node("Node1")
onready var node2 = get_node("Node2")
onready var node3 = get_node("Node3")
onready var node4 = get_node("Node4")
onready var node5 = get_node("Node5")
onready var node6 = get_node("Node6")

onready var userEdge = get_node("UserLine")

onready var edge1 = get_node("Line2D")
onready var node1_label = get_node("Node1/Label")
onready var node2_label = get_node("Node2/Label")
onready var node3_label = get_node("Node3/Label")
onready var node4_label = get_node("Node4/Label")
onready var node5_label = get_node("Node5/Label")
onready var node6_label = get_node("Node6/Label")
onready var moves_left_text = get_node("MovesLeft")

var last_clicked_value = start

func randomly_creating_edge():
	pass 
	
var maximum = 0
var minimum_path = []

func dfs(u, d, visited, path):
	visited[u] = 1
	path.append(u)
	
	if u == d:
		var sum = 0
		for j in path:
			if j==91 or j==99:
				continue
			sum += j
		if sum > maximum:
			maximum = sum
			minimum_path.clear()
			minimum_path.append_array(path)
		print(path, sum)
	else:
		for i in adj[u]:
			if visited[i] == 0:
				dfs(i, d, visited, path)
	
	path.pop_back()
	visited[u] = 0 
	pass 

func find_duplicates(array):
	var result = {}
	for i in array:
		if array.count(i) > 1:
			print("Yes Duplicate Found")
			return true 
	

func _ready():
	available_nodes.append(int(node1_label.text))
	available_nodes.append(int(node2_label.text))
	available_nodes.append(int(node3_label.text))
	available_nodes.append(int(node4_label.text))
	available_nodes.append(int(node5_label.text))
	available_nodes.append(int(node6_label.text))
	position_array.append(node1.position)
	position_array.append(node2.position)
	position_array.append(node3.position)
	position_array.append(node4.position)
	position_array.append(node5.position)
	position_array.append(node6.position)
	
	clicked_nodes.append(start_box.position)
	
	adj[91] = [int(node1_label.text), int(node6_label.text), int(node5_label.text)] 
	adj[int(node1_label.text)] = [91, int(node4_label.text)]
	adj[int(node2_label.text)] = [99, int(node4_label.text)]
	adj[int(node3_label.text)] = [99, int(node4_label.text), int(node5_label.text)]
	adj[int(node4_label.text)] = [int(node2_label.text), int(node1_label.text), int(node6_label.text), int(node3_label.text)]
	adj[int(node5_label.text)] = [91, int(node6_label.text), int(node3_label.text)]
	adj[int(node6_label.text)] = [91, int(node5_label.text), int(node4_label.text)]
	adj[99] = [int(node2_label.text), int(node3_label.text)]
	
	var visited = []
	visited.resize(100)
	visited.fill(0)
	
	var path = []
	
	dfs(91, 99, visited, path)

	var a = find_duplicates(available_nodes)
	if a:
		get_tree().reload_current_scene()
	
	moves_left_text.text = str(moves_left)
	$TotalClickedSum.text = str(total_clicked_sum)
	
	userEdge.default_color =  Color( 0.823529, 0.705882, 0.54902, 1 )
	
	pass 


func _process(delta):
	userEdge.points = clicked_nodes
	moves_left_text.text = str(moves_left)
	$TotalClickedSum.text = str(total_clicked_sum)
	pass 


func _on_Node1_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and (int(node1_label.text) in adj[last_clicked_value]):
			clicked_nodes.append(node1.position)
			last_clicked_value = int(node1_label.text)
			total_clicked_sum += int(node1_label.text)
			moves_left -= 1


func _on_Node2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and (int(node2_label.text) in adj[last_clicked_value]):
			clicked_nodes.append(node2.position)
			last_clicked_value = int(node2_label.text)
			total_clicked_sum += int(node2_label.text)
			moves_left -= 1

func _on_Node3_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and (int(node3_label.text) in adj[last_clicked_value]):
			clicked_nodes.append(node3.position)
			last_clicked_value = int(node3_label.text)
			total_clicked_sum += int(node3_label.text)
			moves_left -= 1

func _on_Node4_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and (int(node4_label.text) in adj[last_clicked_value]):
			clicked_nodes.append(node4.position)
			last_clicked_value = int(node4_label.text)
			total_clicked_sum += int(node4_label.text)
			moves_left -= 1

func _on_Node5_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and (int(node5_label.text) in adj[last_clicked_value]):
			clicked_nodes.append(node5.position)
			last_clicked_value = int(node5_label.text)
			total_clicked_sum += int(node5_label.text)
			moves_left -= 1

func _on_Node6_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and (int(node6_label.text) in adj[last_clicked_value]):
			clicked_nodes.append(node6.position)
			last_clicked_value = int(node6_label.text)
			total_clicked_sum += int(node6_label.text)
			moves_left -= 1
			
			
func connect_the_nodes(answer, available_nodes):
	var answer_nodes = []
	for j in answer:
		answer_nodes.append(available_nodes.find(j))
	var connecting_nodes_position = []
	connecting_nodes_position.append(start_box.position)
	for i in answer_nodes:
		if i != -1:
			connecting_nodes_position.append(position_array[i])
	connecting_nodes_position.append(finish_box.position)
	print(connecting_nodes_position)
	edge1.points = connecting_nodes_position
	edge1.default_color = Color( 1, 0.0784314, 0.576471, 1 )
	
	pass
	

func _on_Button_pressed():
	print("Button pressed")
	connect_the_nodes(minimum_path, available_nodes)
	$MaxResult.text = "Max Sum: %d"%maximum
	if $Result.text != "You Won":
		$Result.text = "Lost!"

	pass # Replace with function body.


func _on_RestartButton_pressed():
	get_tree().reload_current_scene()


func _on_FinishButton_pressed():
	if destination in adj[last_clicked_value]:
		clicked_nodes.append(finish_box.position) # Replace with function body.
	
	if total_clicked_sum == maximum:
		$Result.text = "You Won"
	else:
		$Result.text = "Lost! See the Solve"


func _on_Reset_pressed():
	clicked_nodes.clear()
	clicked_nodes.append(start_box.position)
	total_clicked_sum = 0
	last_clicked_value = start
	moves_left = 6
	pass # Replace with function body.

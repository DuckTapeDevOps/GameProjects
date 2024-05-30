extends Node2D


var chatter_dict = {
	"mobs": [
		{
			"name": "FoolBox",
			"texture": "res://characters/chatters/Foolbox.png",
			"damage": 10,
			"health": 100
		},
		{
			"name": "SkipTitanium",
			"texture": "res://characters/chatters/Raym0nd83.png",
			"damage": 15,
			"health": 80
		},
		{
			"name": "SkipTitanium",
			"texture": "res://characters/chatters/SkipTitanium.png",
			"damage": 20,
			"health": 50
		}
	]
}


var mob_template = preload("res://mob.tscn")


func _ready():
	var mob_data_list = chatter_dict["mobs"]
	for mob_data in mob_data_list:
		create_mob_scene(mob_data)


func create_mob_scene(mob_data):
	var mob_name = mob_data["name"]
	var texture_path = mob_data["texture"]
	var damage = mob_data["damage"]
	var health = mob_data["health"]

	var mob_scene = mob_template.instance()
	
	var sprite = mob_scene.get_node("Slime")
	sprite.texture = load(texture_path)

	#var collision_shape = CollisionShape2D.new()
	#var shape = CircleShape2D.new()  # Adjust shape type and size as needed
	#collision_shape.shape = shape
	#mob_root.add_child(collision_shape)

	#mob_root.set("damage", damage)
	mob_scene.health = health

	var mob_scene_path = "res://characters/chatters/" + mob_name + ".tscn"
	ResourceSaver.save(mob_scene, mob_scene_path)

	print("Mob scene created and saved as: ", mob_scene_path)

func spawn_mob():
	var mob_data_list = chatter_dict["mobs"]
	var random_mob_data = mob_data_list[randi() % mob_data_list.size()]

	var new_mob = load("res://characters/chatters/" + random_mob_data["name"] + ".tscn").instance()
	var path_follow = $PathFollow2D
	path_follow.progress_ratio = randf()
	new_mob.global_position = path_follow.global_position
	add_child(new_mob)

func _on_timer_timeout():
	spawn_mob()

func _on_player_health_depleted():
	$GameOver.visible = true
	get_tree().paused = true

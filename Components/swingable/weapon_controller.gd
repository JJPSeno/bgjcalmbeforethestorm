extends Node2D

signal weapon_changed(weapon: Area2D)

enum Weapons {AVG, GREAT}

@onready var average_sword_node: Node2D = $"Average Sword"
@onready var average_sword: Area2D = $"Average Sword/Weapon"
@onready var great_sword_node: Node2D = $"Great Sword"
@onready var great_sword: Area2D = $"Great Sword/Weapon"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	QuestSystem.finish_toolsmith_quest_2.connect(_on_weapon_upgraded)
	average_sword_node.visible = false
	average_sword.monitorable = false
	average_sword.monitoring = false
	great_sword_node.visible = false
	great_sword.monitorable = false
	great_sword.monitoring = false
	if !GameManager.is_weapon_upgraded:
		change_weapon(Weapons.AVG)
	else:
		change_weapon(Weapons.GREAT)
		
#func _process(delta: float) -> void:
	#print("helo",[
	#average_sword.monitorable,
	#average_sword.monitoring,
	#great_sword.monitorable,
	#great_sword.monitoring
	#])

func change_weapon(weapon: Weapons) -> void:
	average_sword_node.visible = false
	average_sword.monitorable = false
	average_sword.monitoring = false
	great_sword_node.visible = false
	great_sword.monitorable = false
	great_sword.monitoring = false
	match weapon:
		Weapons.AVG:
			great_sword_node.visible = false
			average_sword_node.visible = true
			weapon_changed.emit(average_sword)
		Weapons.GREAT:
			average_sword_node.visible = false
			great_sword_node.visible = true
			weapon_changed.emit(great_sword)


func return_current_weapon() -> Node2D:
	if !GameManager.is_weapon_upgraded:
		return average_sword
	else:
		return great_sword


func _on_weapon_upgraded() -> void:
	change_weapon(Weapons.GREAT)
	average_sword.monitorable = false
	average_sword.monitoring = false
	great_sword.monitorable = false
	great_sword.monitoring = false
	
	for child in average_sword.get_children():
		if child is CollisionShape2D:
			child.set_deferred('disabled', true)

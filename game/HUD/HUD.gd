extends CanvasLayer

const MAX_HEALTH_WIDTH = 50


onready var root := $Root
onready var health := $Root/Health
onready var score := $Score

	
func _process(delta: float) -> void:
	var player := _find_player()
	if not player:
		root.visible = false
		score.visible = false
		return
	
	root.visible = true
	score.visible = true
	_update_health(player)
	_update_ammo(player)
	_update_score(player)

func _find_player() -> Player:
	var nodes := get_tree().get_nodes_in_group("player")
	if nodes.size() > 0:
		return nodes[0] as Player
	return null

func _update_health(player: Player) -> void:
	var width = player.health * MAX_HEALTH_WIDTH / player.MAX_HEALTH
	health.scale.x = width

func _update_ammo(player: Player) -> void:
	for i in range(1, player.MAX_AMMO + 1):
		var node_path := "Root/AmmoBars/Ammo%s" % i
		var node := get_node(node_path)
		node.visible = i <= player.ammo

func _update_score(player: Player) -> void:
	score.text = "%d" % player.score

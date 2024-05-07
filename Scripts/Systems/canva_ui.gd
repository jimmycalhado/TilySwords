extends CanvasLayer

@onready var time_label: Label = $TimeLabel
@onready var meat_label: Label = $Panel2/MeatLabel


func _process(delta:float):
	
	time_label.text = GameManage.time_elapsed_string
	meat_label.text = str(GameManage.meat_counter)
	

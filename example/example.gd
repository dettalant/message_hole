extends Control

func _ready() -> void:
    MessageHole.set_is_enable_log(true)


func _input(e: InputEvent):
    if e.is_action_pressed("ui_accept"):
        _post_test()

    if e.is_action_pressed("ui_cancel"):
        _get_log_test()


func _post_test() -> void:
    MessageHole.post("echo", self, "TEST_MESSAGE")


func _get_log_test() -> void:
    MessageHole.post("print_log", self)


func _method_echo(m: MessagePack) -> void:
    print("method_echo: %s, %s" % [m.get_sender().name, m.get_message()])


func _method_print_log(_m: MessagePack) -> void:
    print("method_print_log: ", MessageHole.get_log())

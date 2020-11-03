extends Control


func _input(e: InputEvent):
    if e.is_action_pressed("ui_accept"):
        _post_test()

    if e.is_action_pressed("ui_cancel"):
        _get_log_test()


func _post_test() -> void:
    var m = MessageHole.gen_message(self, "TEST MESSAGE")
    MessageHole.post("echo", m)


func _get_log_test() -> void:
    var m = MessageHole.gen_message(self)
    MessageHole.post("print_log", m)


func _method_echo(m: Dictionary) -> void:
    print("method_echo: %s, %s" % [m.sender.name, m.message])


func _method_print_log(_m: Dictionary) -> void:
    print("method_print_log: ", MessageHole.get_log())

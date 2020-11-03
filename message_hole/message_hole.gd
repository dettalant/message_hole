extends Node

onready var _log = $MessageLog

var is_enable_log := true

func post(target: String, message: Dictionary) -> void:
    var group = _get_group_name(target)
    var method = _get_method_name(target)
    var log_str = target + ": " + str(message)

    var tree := get_tree()
    if tree.has_group(group):
        tree.call_group(group, method, message)
    else:
        var err_str = "MessageHole Error: %s group not found" % group
        printerr(err_str)
        log_str += " // " + err_str

    if is_enable_log: _log.append(log_str)


func get_log() -> Array:
    return _log.LOG_POSTS


static func _get_group_name(target: String) -> String:
    return "method_" + target


static func _get_method_name(target: String) -> String:
    return "_method_" + target


static func gen_message(sender: Object, message = "") -> Dictionary:
    return {
        sender = sender,
        message = message,
    }

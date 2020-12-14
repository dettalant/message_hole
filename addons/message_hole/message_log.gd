extends Object


var _log_posts := []
var _is_enable_log := false

func push_log(log_dict: Dictionary) -> void:
    _log_posts.append(log_dict)


func get_logs() -> Array:
    return _log_posts


func gen_log_dict(target: String, sender: Node, message, args: Dictionary) -> Dictionary:
    return {
        "target": target,
        "sender": sender,
        "message": message,
        "args": args,
        "is_sent": true
    }


func is_enable_log() -> bool:
    return _is_enable_log


func set_is_enable_log(b: bool) -> void:
    _is_enable_log = b

extends Object

const LOG_POSTS := []

var _is_enable_log := false

func push_log(log_str: String) -> void:
    LOG_POSTS.append(log_str)


func get_logs() -> Array:
    return LOG_POSTS


func is_enable_log() -> bool:
    return _is_enable_log


func set_is_enable_log(b: bool) -> void:
    _is_enable_log = b

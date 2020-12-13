extends Node

const MessageLog = preload("res://addons/message_hole/message_log.gd")
var _m_log = MessageLog.new()

func post(target: String, sender: Node, message = "", args := {}) -> void:
    var m_pack = MessagePack.new(sender, message, args)
    var group = _get_group_name(target)
    var method = _get_method_name(target)
    var is_failed = false

    var tree := get_tree()
    if tree.has_group(group):
        tree.call_group(group, method, m_pack)
    else:
        var err_str = "MessageHole Error: group of %s is not found" % group
        push_warning(err_str)
        is_failed = true

    if _m_log.is_enable_log():
        var log_dict = _m_log.gen_log_dict(target, sender, message, args)
        if is_failed: log_dict.is_sent = false
        _m_log.push_log(log_dict)


func get_log() -> Array:
    return _m_log.get_logs()


func is_enable_log() -> bool:
    return _m_log.is_enable_log()


func set_is_enable_log(b: bool) -> void:
    _m_log.set_is_enable_log(b)


static func _get_group_name(target: String) -> String:
    return "method_" + target


static func _get_method_name(target: String) -> String:
    return "_method_" + target

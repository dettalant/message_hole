extends Node

const MessageLog = preload("res://addons/message_hole/message_log.gd")
var _m_log = MessageLog.new()

func post(target: String, message: MessagePack) -> void:
    var group = _get_group_name(target)
    var method = _get_method_name(target)
    var log_str = target + ": " + str(message.get_message())

    var tree := get_tree()
    if tree.has_group(group):
        tree.call_group(group, method, message)
    else:
        var err_str = "MessageHole Error: %s group not found" % group
        push_warning(err_str)
        log_str += " // " + err_str

    if _m_log.get_is_enable_log(): _m_log.push_log(log_str)


func get_log() -> Array:
    return _m_log.get_logs()


func get_is_enable_log() -> bool:
    return _m_log.get_is_enable_log()


func set_is_enable_log(b: bool) -> void:
    _m_log.set_is_enable_log(b)


static func _get_group_name(target: String) -> String:
    return "method_" + target


static func _get_method_name(target: String) -> String:
    return "_method_" + target


static func gen_message(sender: Node, message = "", args := {}) -> MessagePack:
    return MessagePack.new(sender, message, args)

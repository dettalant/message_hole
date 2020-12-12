extends Object

class_name MessagePack

var _sender: Node = null
var _message = null
var _args: Dictionary = {}

func _init(sender: Node, message = "", args := {}) -> void:
    _sender = sender
    _message = message
    _args = args


func get_sender() -> Node:
    return _sender


func get_message():
    return _message


func get_args() -> Dictionary:
    return _args


func is_string_message() -> bool:
    return _message is String


func is_int_message() -> bool:
    return _message is int


func is_float_message() -> bool:
    return _message is float


func is_array_message() -> bool:
    return _message is Array


func is_dictionary_message() -> bool:
    return _message is Dictionary


func is_specify_class_message(c_name: String) -> bool:
    if !(_message is Object): return false
    return _message.get_class() == c_name


func is_number_message() -> bool:
    return _message is int || _message is float

extends "res://addons/gut/test.gd"

class FooClass:
    extends Node

    var _text := ""

    func _init() -> void:
        add_to_group("method_foo")

    func _method_foo(m: MessagePack) -> void:
        _text = m.get_message()


func before_each():
    var node: FooClass = autoqfree(FooClass.new())
    add_child_autoqfree(node)
    # reset MessageHole states
    MessageHole.set_is_enable_log(false)
    MessageHole.get_log().clear()


func test_add_one() -> void:
    assert_eq(2, 1 + 1)


func test_post() -> void:
    var node: FooClass = autoqfree(FooClass.new())
    add_child_autoqfree(node)
    MessageHole.post("foo", self, "foobar")

    yield(yield_for(0.01), YIELD)
    assert_eq(node._text, "foobar")


func test_get_log() -> void:
    assert_eq(MessageHole.get_log().size(), 0)

    # Not generate log if is_enable_log is false
    MessageHole.post("foo", self, "foobar")
    assert_eq(MessageHole.get_log().size(), 0)

    MessageHole.set_is_enable_log(true)

    MessageHole.post("foo", self, "foobar")
    assert_eq(MessageHole.get_log().size(), 1)
    assert_eq_deep(MessageHole.get_log()[0], {
        "target": "foo",
        "sender": self,
        "message": "foobar",
        "args": {},
        "is_sent": true
    })


func test_is_enable_log() -> void:
    var _MessageHole = load("res://addons/message_hole/message_hole.gd")
    var mh = autoqfree(_MessageHole.new())
    # check default value
    assert_false(mh.is_enable_log())

    # check set true
    mh.set_is_enable_log(true)
    assert_true(mh.is_enable_log())

    # check set false
    mh.set_is_enable_log(false)
    assert_false(mh.is_enable_log())


func test_get_group_name() -> void:
    var test = [
        ["foo", "method_foo"],
        ["bar", "method_bar"],
        ["foo_bar", "method_foo_bar"],
        ["_foo_bar", "method__foo_bar"]
    ]

    for t in test:
        var src = t[0]
        var expected = t[1]
        assert_eq(MessageHole._get_group_name(src), expected)


func test_get_method_name() -> void:
    var test = [
        ["foo", "_method_foo"],
        ["bar", "_method_bar"],
        ["foo_bar", "_method_foo_bar"],
        ["_foo_bar", "_method__foo_bar"]
    ]

    for t in test:
        var src = t[0]
        var expected = t[1]
        assert_eq(MessageHole._get_method_name(src), expected)


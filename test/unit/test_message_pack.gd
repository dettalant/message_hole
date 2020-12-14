extends "res://addons/gut/test.gd"

class FooClass:
    extends Object

func test_object_init() -> void:
    var node = autofree(Node.new())
    var args_src := {"is_test": true}
    var tests = [
        [autofree(MessagePack.new(self)), [self, "", {}]],
        [autofree(MessagePack.new(node, "foobar")), [node, "foobar", {}]],
        [
            autofree(MessagePack.new(self, "barbar", args_src)),
            [self, "barbar", args_src]
        ],
    ]

    for t in tests:
        var pack = t[0]
        var sender = t[1][0]
        var message = t[1][1]
        var args = t[1][2]
        assert_eq(pack.get_sender(), sender)
        assert_eq_deep(pack.get_message(), message)
        assert_eq_deep(pack.get_args(), args)


func test_getters() -> void:
    var node = autofree(Node.new())
    var tests = [
        [self, "foo", {"is_test": true}],
        [node, 334, {}],
        [self, [0, 1, 2], {"test": "ttt"}],
        [node, {"ttt": "ppp"}, {}],
        [self, node, {}]
    ]

    for t in tests:
        var sender = t[0]
        var message = t[1]
        var args = t[2]
        var pack = autofree(MessagePack.new(sender, message, args))
        assert_eq(pack.get_sender(), sender)
        assert_eq_deep(pack.get_message(), message)
        assert_eq_deep(pack.get_args(), args)


func test_is_string_message() -> void:
    var tests = [
        ["foo", true],
        [1, false],
        [1.1, false],
        [[], false],
        [{}, false],
    ]

    for t in tests:
        var src = t[0]
        var pack = autofree(MessagePack.new(self, src))
        var expected = t[1]
        assert_eq(pack.is_string_message(), expected, "Message value: %s" % str(src))


func test_is_int_message() -> void:
    var tests = [
        ["foo", false],
        [1, true],
        [1.1, false],
        [[], false],
        [{}, false],
    ]

    for t in tests:
        var src = t[0]
        var pack = autofree(MessagePack.new(self, src))
        var expected = t[1]
        assert_eq(pack.is_int_message(), expected, "Message value: %s" % str(src))


func test_is_float_message() -> void:
    var tests = [
        ["foo", false],
        [1, false],
        [1.1, true],
        [[], false],
        [{}, false],
    ]

    for t in tests:
        var src = t[0]
        var pack = autofree(MessagePack.new(self, src))
        var expected = t[1]
        assert_eq(pack.is_float_message(), expected, "Message value: %s" % str(src))


func test_is_array_message() -> void:
    var tests = [
        ["foo", false],
        [1, false],
        [1.1, false],
        [[], true],
        [{}, false],
    ]

    for t in tests:
        var src = t[0]
        var pack = autofree(MessagePack.new(self, src))
        var expected = t[1]
        assert_eq(pack.is_array_message(), expected, "Message value: %s" % str(src))


func test_is_dictionary_message() -> void:
    var tests = [
        ["foo", false],
        [1, false],
        [1.1, false],
        [[], false],
        [{}, true],
    ]

    for t in tests:
        var src = t[0]
        var pack = autofree(MessagePack.new(self, src))
        var expected = t[1]
        assert_eq(pack.is_dictionary_message(), expected, "Message value: %s" % str(src))


func test_is_number_message() -> void:
    var tests = [
        ["foo", false],
        [1, true],
        [1.1, true],
        [[], false],
        [{}, false],
    ]

    for t in tests:
        var src = t[0]
        var pack = autofree(MessagePack.new(self, src))
        var expected = t[1]
        assert_eq(pack.is_number_message(), expected, "Message value: %s" % str(src))


func test_is_specify_class_message() -> void:
    var tests = [
        [autofree(Node.new()), "Node", true],
        # Input a inherited class name is return false
        [autofree(Node.new()), "Object", false],
        [autofree(Node2D.new()), "Node2D", true],
        [autofree(Node2D.new()), "FooClass", false],
        # Custom class's `get_class()` is always return a extends native class in Godot 3.2.3
        [autofree(FooClass.new()), "Object", true],
        [autofree(FooClass.new()), "Node", false],
    ]

    for t in tests:
        var pack = autofree(MessagePack.new(self, t[0]))
        var c_name = t[1]
        var expected = t[2]
        assert_eq(
            pack.is_specify_class_message(c_name),
            expected,
            "Message class is %s, input class name is %s" % [
                pack.get_message().get_class(),
                c_name
            ]
        )

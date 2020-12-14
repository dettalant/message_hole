extends "res://addons/gut/test.gd"

const MessageLog = preload("res://addons/message_hole/message_log.gd")

var _m_log = null

func before_each() -> void:
    _m_log = autofree(MessageLog.new())


func test_gen_log_dict() -> void:
    var node = autofree(Node.new())
    var tests = [
        ["foo", self, "foobar", {"is_test": true}],
        ["bar", node, "barbar", {}],
        ["foo_bar", self, "barfoo", {"foobar": "fooooo"}]
    ]

    for t in tests:
        var target = t[0]
        var sender = t[1]
        var message = t[2]
        var args = t[3]
        assert_eq_deep(_m_log.gen_log_dict(target, sender, message, args), {
            "target": target,
            "sender": sender,
            "message": message,
            "args": args,
            "is_sent": true
        })


func test_is_enable_log() -> void:
    # default value
    assert_false(_m_log.is_enable_log())
    # set true
    _m_log.set_is_enable_log(true)
    assert_true(_m_log.is_enable_log())
    # set false
    _m_log.set_is_enable_log(false)
    assert_false(_m_log.is_enable_log())


func test_push_log() -> void:
    var node = autofree(Node2D.new())
    var log_dict = _m_log.gen_log_dict("foo", self, "foobar", {"is_test": true})
    var log_dict2 = _m_log.gen_log_dict("bar", node, "barfoo", {"test": "ttt"})
    assert_eq(_m_log._log_posts.size(), 0)

    _m_log.push_log(log_dict)
    assert_eq(_m_log._log_posts.size(), 1)
    _m_log.push_log(log_dict2)

    assert_eq(_m_log._log_posts.size(), 2)
    assert_eq_deep(_m_log._log_posts, [log_dict, log_dict2])


func test_get_logs() -> void:
    var node = autofree(Node2D.new())
    assert_eq_deep(_m_log.get_logs(), [])
    var log_dict = _m_log.gen_log_dict("foo", self, "foobar", {"is_test": true})
    var log_dict2 = _m_log.gen_log_dict("bar", node, "barfoo", {"test": "ttt"})

    _m_log.push_log(log_dict)
    assert_eq_deep(_m_log.get_logs(), [log_dict])

    _m_log.push_log(log_dict2)
    assert_eq_deep(_m_log.get_logs(), [log_dict, log_dict2])


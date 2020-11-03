MessageHole
=============

Tiny message post script for [godot](https://github.com/godotengine/godot).

Compatible above Godot 3.1

## Usage

1. Add `res://message_hole/message_hole.tscn` to Autoload setting
2. Set `method_foobar` group and `_method_foobar` function to post receiver Node
3. Call `MessageHole.post("foobar", MessageHole.gen_message(self, "Message Text"))`
4. Auto triggered `_method_foobar`

## Licence

MIT

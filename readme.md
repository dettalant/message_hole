MessageHole
=============

Tiny message post script for [godot](https://github.com/godotengine/godot).

Compatible above Godot 3.1

## Usage

1. Import `addons/message_hole` folder to your game project.
2. Add `res://addons/message_hole/message_hole.gd` to Autoload setting.
3. Set `method_foobar` group and `_method_foobar` function to post receiver Node
4. Call `MessageHole.post("foobar", self, "Message Text")`
5. Auto triggered `_method_foobar` via `SceneTree.call_group("method_foobar", "_method_foobar")`

## Licence

MIT

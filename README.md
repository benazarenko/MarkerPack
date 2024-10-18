
# Marker trigger datapack

This datapack gives you ability to use markers to trigger various events. You can configurate markers to run commands if a player is in a certain range near it. There are two ways to configure the area, rectangular and radial (with `dx dy dz` and `distance` selectors respectively). This also features different ways to react to the player joining the area. You can configure the area to run a command on every tick, or only once, on enter and leave.

## Installation

Copy the datapack to your `<world_name>/datapacks` folder, and run the game. By default you should see a green message `Marker datapack loaded`. If you want to hide this message, just go to [here](data/markerpack/function/backend/load.mcfunction) and remove/comment the line that starts with `tellraw`.

## Usage

All the configuration is done via marker `data` nbt tag, and the `tag` command (`Tags` nbt tag). There are two types of marker triggers:

- `tick` - runs a command on every tick.
- `trigger` - runs different commands on player entering the area, and player leaving the area.

Also there are two types of area configuration: rectangular and radial. All this can be configured by adding info to your marker's `data` nbt tag.

### Radial trigger

Let's create a radial trigger marker that runs commands on player entering and leaving the area of 5 blocks around the marker. To make this you first need to modify your marker's `data` nbt:

```json
{
	"r": "5",
	"on_enter": "say hi",
	"on_leave": "say bye"
}
```

Here you see the required nbt fields stored in the `data`. You can stay close to your marker and run
`data modify entity @n[type=marker] data.r set value 5`
or if, you use Axiom, just rightclick the marker and copy-paste all the values in the editor.

Next we have to set type of our marker and enable it. To do this, just add `trigger` and `enable` tags with `tag` command
`tag @n[type=marker] trigger`

If you did everything correctly, getting 5 blocks close to your marker will run the command `say hi` as the marker. And if you leave the area, it will run `say bye` command.

### Rectangular tick

Let's create a marker that will constantly damage the player if they enter a rectangular area of 4x4x4 blocks around the marker. The `data` nbt of our marker will look like this:

```json
{
	"dx": "3",
	"dy": "3",
	"dz": "3",
	"on_enter": "damage @p 1 magic",
	"x": "-2",
	"y": "-2",
	"z": "-2"
}
```

The `x y z ` nbts work the same as if you'd run `execute positioned ~-2 ~-2 ~-2 `, and `dx dy dz` work the same as `execute if entity @s[dx=3,dy=3,dz=3]`. You need to specify all of them to make the marker work. The  `on_enter` specifies the command that runs every tick.

Next we add tags `tick` and `enable` with `tag` command to the marker and it should work.

## Detailed description

The datapack does 4 checks on every tick. It uses macros but only when the minimal conditions are met. Minimal conditions are:

- Marker has `tick` or `trigger` tag, and an `enable` tag.
- A player is 10 blocks near the marker.

> [!IMPORTANT]
> For optimization purpose, this datapack restricts the maximum radius check to **10** blocks. Make sure that the area of your marker is inside the radius.
> You can modify the maximum radius. See the [advanced section](#advanced).

Only if these conditions are met, the datapack runs the macro functions.

All the commands are run as the marker, and at marker's location. You can write any command to the `on_enter` or `on_leave`, and it will run. Be sure that your command has correct syntax, or the marker won't work.

In some `trigger` markers you might want to have only `on_enter` or `on_leave` commands. But both are required to run. To make it work, you can set the other value to `function markerpack:nop`. This is an empty function that does nothing. If the player dies while in the `trigger` area, the `on_leave` command will run after the player respawns.

The datapack works on multiplayer. But it doesn't give you information about the players that has entered the area. *This could be added in future releases as a macro.*

### NBT tags

|      NBT tag     |                                                                                            Description                                                                                            |
|:----------------:|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   `x`, `y`, `z`  | Float. Required for rectangular area check.Specifies the starting point of the area. Equal to `execute positioned ~<x> ~<y> ~<z>`.                                                               |
| `dx`, `dy`, `dz` | Float. Required for rectangular area check. Specifies the rectangular extension of area. Equal to `execute if entity @s[dx=<dx>,dy=<dy>,dz=<dz>]`.                                                |
|        `r`       | Float. Primary. Required for radial area check. Specifies the radius around the marker that will be checked. Equal to `execute if entity @s[distance=<r>]`.                                                |
|    `on_enter`    | String. Required for any type and area check. The command that will run if the player enters the area (if type is `trigger`) or will run constantly if player is in the area (if type is `tick`). |
|    `on_leave`    | String. Required for `trigger` type. The command that will run when the player leaves the area.                                                                                                   |

Primary tags are checked first. If you have both `x y z` and `r`, it will ignore `x y z` and use `r`.

### Tags

|         Tag         |                                                  Description                                                 |
|:-----------:|--------------------------------------------------------------------------------------------------------------|
|       `enable`      | Required. Enables the marker area check. Remove if you want to disable it.                                   |
| `tick` or `trigger` | Required. Specifies the marker type. Make sure that your marker has only one of those.                       |
|     `trigger.on`    | Technical. Added to the marker if there are any players in the area checked. |

### Scoreboards

|    Scoreboard    |                  Description                  |
|:----------------:|-----------------------------------------------|
| `markerpack.tmp` | Dummy. Scoreboard that stores temporary data. |

## Advanced

You can modify the maximum area check distance in the [tick](data/markerpack/function/tick.mcfunction) file. In the `@e` selector there are `distance` argument that equals to `10..` or `..10`. Here `10` is the maximum area check distance in blocks. If you want to modify it, change `10` to any other float value.

> [!WARNING]
> Remember, this is an optimization constraint. From my point of view, having a large amount of markers checked in one tick, might lead to potential performance issues.

## Help and contribution

If you find any mistakes or errors, feel free to write an [issue](../../issues).

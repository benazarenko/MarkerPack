execute at @a as @e[type=marker,distance=..10,tag=enable,tag=tick] run function markerpack:backend/tick with entity @s data
execute at @a as @e[type=marker,distance=..10,tag=enable,tag=trigger] run function markerpack:backend/trigger with entity @s data

execute at @a as @e[type=marker,distance=10..,tag=enable,tag=tick,tag=trigger.on] run function markerpack:backend/tick with entity @s data
execute at @a as @e[type=marker,distance=10..,tag=enable,tag=trigger,tag=trigger.on] run function markerpack:backend/trigger with entity @s data

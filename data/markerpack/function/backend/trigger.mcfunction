# Check if there are any players in marker coordinates
# returns 0 if there are none
execute at @s unless data entity @s data.r store result score #std markerpack.tmp run function markerpack:backend/xyz with entity @s data
execute at @s if data entity @s data.r store result score #std markerpack.tmp run function markerpack:backend/r with entity @s data
$execute at @s if score #std markerpack.tmp matches 0 if entity @s[tag=trigger.on] run $(on_leave)
execute if score #std markerpack.tmp matches 0 if entity @s[tag=trigger.on] run tag @s remove trigger.on
execute if score #std markerpack.tmp matches 0 run return 0

# This code will run only if conditions are met
$execute at @s if entity @s[tag=!trigger.on] run $(on_enter)
tag @s add trigger.on

# Check if there are any players in marker coordinatex
# returns 0 if there are none
execute at @s unless data entity @s data.r store result score #std markerpack.tmp run function markerpack:backend/xyz with entity @s data
execute at @s if data entity @s data.r store result score #std markerpack.tmp run function markerpack:backend/r with entity @s data
execute if score #std markerpack.tmp matches 0 run return 0

# This code will run only if conditions are met
$$(on_enter)

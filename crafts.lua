


minetest.register_craftitem("farming_super:rice_bag", {
	description = "Rice Bag",
	inventory_image = "farming_super_rice_bag.png",
	groups = {},
})


minetest.register_craft({
	output = "farming_super:rice_bag 1",
	recipe = {
		{"farming_super:seed_rice","farming_super:seed_rice","farming_super:seed_rice"},
		{"farming_super:seed_rice","farming_super:seed_rice","farming_super:seed_rice"},
		{"farming_super:seed_rice","farming_super:seed_rice","farming_super:seed_rice"},
	}
})

minetest.register_craft({
	output = "farming_super:seed_rice 9",
	type = "shapeless",
	recipe = {"farming_super:rice_bag"},
})



function register_bag(modname, itemname, desc, inventory_image)
	minetest.register_craftitem(modname..":"..itemname.."_bag", {
		description = desc,
		inventory_image = "farming_super_rice_bag.png^([combine:32x32:8,8="..inventory_image.."^[resize:16x16)",
		groups = {},
	})
	
	minetest.register_craft({
		output = modname..":"..itemname.."_bag 1",
		recipe = {
			{modname..":"..itemname, modname..":"..itemname, modname..":"..itemname},
			{modname..":"..itemname, modname..":"..itemname, modname..":"..itemname},
			{modname..":"..itemname, modname..":"..itemname, modname..":"..itemname},
		}
	})
	
	minetest.register_craft({
		output = modname..":"..itemname.." 9",
		type = "shapeless",
		recipe = {modname..":"..itemname.."_bag"},
	})
end


register_bag("farming_super", "corn", "Corn Bag", "farming_super_corn.png")
register_bag("farming_super", "soybeans", "Soybean Bag", "farming_super_soybeans.png")
register_bag("farming_super", "onion_red", "Red Onion Bag", "farming_super_onion_red.png")
register_bag("farming_super", "onion_yellow", "Yellow Onion Bag", "farming_super_onion_yellow.png")
register_bag("farming_super", "onion_white", "White Onion Bag", "farming_super_onion_white.png")
register_bag("farming_super", "carrot", "Carrot Bag", "farming_super_carrot.png")
register_bag("farming_super", "carrot_red", "Red Carrot Bag", "farming_super_carrot_red.png")
register_bag("farming_super", "carrot_yellow", "Yellow Carrot Bag", "farming_super_carrot_yellow.png")
register_bag("farming_super", "carrot_purple", "Purple Carrot Bag", "farming_super_carrot_purple.png")

-- a shim left over from development versions
minetest.register_alias("farming_super:soybean_bag", "farming_super:soybeans_bag")









farming_super.registered_plants = {}




function deepclone(t)
	if type(t) ~= "table" then 
		return t 
	end
	
	local meta = getmetatable(t)
	local target = {}
	
	for k, v in pairs(t) do
		if type(v) == "table" then
			target[k] = deepclone(v)
		else
			target[k] = v
		end
	end
	
	setmetatable(target, meta)
	
	return target
end










-- hoes are defined in farming, no need to override here






local base_speed = 1

-- how often node timers for plants will tick, +/- some random value
local function tick(pos)
	minetest.get_node_timer(pos):start(math.random(base_speed * 2, base_speed * 3))
end
-- how often a growth failure tick is retried (e.g. too dark)
local function tick_again(pos)
	minetest.get_node_timer(pos):start(math.random(base_speed, base_speed * 2))
end

-- Seed placement
farming_super.place_seed = function(itemstack, placer, pointed_thing, plantname)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return itemstack
	end
	if pt.type ~= "node" then
		return itemstack
	end

	local under = minetest.get_node(pt.under)
	local above = minetest.get_node(pt.above)

	local player_name = placer and placer:get_player_name() or ""

	if minetest.is_protected(pt.under, player_name) then
		minetest.record_protection_violation(pt.under, player_name)
		return
	end
	if minetest.is_protected(pt.above, player_name) then
		minetest.record_protection_violation(pt.above, player_name)
		return
	end

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return itemstack
	end
	if not minetest.registered_nodes[above.name] then
		return itemstack
	end

	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y+1 then
		return itemstack
	end

	-- check if you can replace the node above the pointed node
	if not minetest.registered_nodes[above.name].buildable_to then
		return itemstack
	end

	-- check if pointing at soil
	if minetest.get_item_group(under.name, "soil") < 2 then
		return itemstack
	end

	-- add the node and remove 1 item from the itemstack
	minetest.add_node(pt.above, {name = plantname, param2 = 1})
	tick(pt.above)
	if not (creative and creative.is_enabled_for
			and creative.is_enabled_for(player_name)) then
		itemstack:take_item()
	end
	return itemstack
end



local function cut_whole_plant(pos, oldnode, oldmetadata, digger)
	
	local p = {x=pos.x, y=pos.y, z=pos.z}
	local old_def = minetest.registered_items[oldnode.name]
	local bn = old_def.base_plant
	print("cutting bp: ".. bn)
	local dinv = digger:get_inventory();
	
	-- go down
	while true do
		p.y = p.y - 1
		
		local n = minetest.get_node_or_nil(p)
		if not n then
			break
		end
		local n_def = minetest.registered_items[n.name]
		if not n_def or not n_def.base_plant or n_def.base_plant ~= bn then
			break
		end
		
		-- dig node
		local drops = minetest.get_node_drops(n.name)
		for _, stack in ipairs(drops) do
			dinv:add_item("main", stack)
		end
				
		minetest.set_node(p, {name="air"})
	end
	
	-- go up
	p = {x=pos.x, y=pos.y, z=pos.z}
	while true do
		p.y = p.y + 1
		
		local n = minetest.get_node_or_nil(p)
		if not n then
			break
		end
		local n_def = minetest.registered_items[n.name]
		if not n_def or not n_def.base_plant or n_def.base_plant ~= bn then
			break
		end
		
		-- dig node
		local drops = minetest.get_node_drops(n.name)
		for _, stack in ipairs(drops) do
			dinv:add_item("main", stack)
		end
		
		minetest.set_node(p, {name="air"})
	end
	
end


local function install_plant(def, pos, step)
	if not step then
		return
	end

	local bp = def.base_plant
	print("tc ".. def.tier_count)
	local tc = def.tier_count
	
	local pos2 = {x=pos.x, y=pos.y, z=pos.z}
	
	local nname = def.base_plant .. "_"..step.."_1"
	local first_def = minetest.registered_items[nname]
	
	for i = 1,first_def.tier_count do
		local name = def.base_plant .. "_"..step.."_"..i
		print("node name "..name)
		local new_def = minetest.registered_items[name]
	
		local placenode = {name = name}
		if new_def.place_param2 then
			placenode.param2 = new_def.place_param2
		end
		minetest.swap_node(pos2, placenode)
		
		pos2.y = pos2.y + 1
	end
	
end


local function get_seed_variant(def, nitro)
	if not def.seed_variants then
		return def.base_plant
	end
	
	
	for _,v in pairs(def.seed_variants) do
		if v.minNitrogen <= nitro and v.maxNitrogen >= nitro then
			return v.name
		end
	end
	
	return def.base_plant
end


farming_super.grow_plant = function(pos, elapsed)
	local node = minetest.get_node(pos)
	local name = node.name
	local def = minetest.registered_nodes[name]
print("gp name ".. name)
	local bp = def.base_plant
	print("base_plant ".. bp)
	print("next_growth_step ".. (def.next_growth_step or "end"))


	
	
	-- grow seed
	if minetest.get_item_group(node.name, "seed") and def.fertility then
		local soil_node = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
		if not soil_node then
			tick_again(pos)
			return
		end
		
		-- omitted is a check for light, we assume seeds can germinate in the dark.
		for _, v in pairs(def.fertility) do
			if minetest.get_item_group(soil_node.name, v) ~= 0 then
				
				local soil_meta = minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z})
				local nlevel = soil_meta:get_int("nitrogen")
				if nlevel == 0 then
					nlevel = 9
					soil_meta:set_int("nitrogen", nlevel)
				end
				print("nlevel: " ..nlevel)
				local var_name = get_seed_variant(def, nlevel) .. "_1_1"
				local var_def = minetest.registered_items[var_name]
				print(dump2(var_def))
				if var_name == "death" or var_def == nil then
					minetest.set_node(pos, {name="air"})
					return
				end
				
				install_plant(var_def, pos, 1)
				
				if var_def.groups.use_nitrogen then
					soil_meta:set_int("nitrogen", math.max(1, nlevel - var_def.groups.use_nitrogen))
					print("new nlevel: " ..nlevel - (var_def.groups.use_nitrogen or 0))
				end
				
				--[[local placenode = {name = def.base_plant .. "_1_1"}
				if def.place_param2 then
					placenode.param2 = def.place_param2
				end
				]] -- minetest.swap_node(pos, placenode)
			--	if minetest.registered_nodes[def.base_plant .. "_1_1"].next_plant then
				tick(pos)
				return
			--		return
			--	end
			end
		end

		return
	end

	
	
	
	-- check if on wet soil
	local below = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
	if minetest.get_item_group(below.name, "soil") < 3 then
		tick_again(pos)
		print("not wet")
		return
	end

	
	-- check light
	local light = minetest.get_node_light(pos)
	if not light or light < def.minlight or light > def.maxlight then
		tick_again(pos)
		print("too dim ".. light.. ":"..def.minlight..":"..def.maxlight)
		return
	end

	
	-- grow
	install_plant(def, pos, def.next_growth_step)

	-- new timer needed?
	if def.next_growth_step then
		tick(pos)
	else -- end of growth, give nutrients
		local soil_meta = minetest.get_meta({x = pos.x, y = pos.y - 1, z = pos.z})
		if def.groups.fix_nitrogen then
			local nlevel = soil_meta:get_int("nitrogen")
			soil_meta:set_int("nitrogen", math.min(16, nlevel + def.groups.fix_nitrogen))
		end
	end
	return
end




-- Register plants
farming_super.register_plant = function(name, def)
	local mname = name:split(":")[1]
	local pname = name:split(":")[2]
	
	local def_drops = def.drops or {}
	
	-- Check def table
	if not def.description then
		def.description = "Seed"
	end
	if not def.inventory_image then
		def.inventory_image = "unknown_item.png"
	end
	if not def.steps then
		return nil
	end
	if type(def.steps) == "number" then
		def.steps = {def.steps}
	end
	if not def.minlight then
		def.minlight = 1
	end
	if not def.maxlight then
		def.maxlight = 14
	end
	if not def.fertility then
		def.fertility = {}
	end

	if def.place_param2 == "plus" then
		def.place_param2 = 1
	elseif def.place_param2 == "hex" then
		def.place_param2 = 2 
	elseif def.place_param2 == "hatch" or def.place_param2 == "#" then
		def.place_param2 = 3 -- the shape of #
	elseif def.place_param2 == "V" or def.place_param2 == "v" then
		def.place_param2 = 4 -- used by dry_shrub
	elseif def.place_param2 == "X" or def.place_param2 == "x" then
		def.place_param2 = 0 -- regular plants
	end
	
	local base_plant = mname .. ":" .. pname
	

	-- Register seed
	local g = {seed = 1, snappy = 3, attached_node = 1, flammable = 2}
	for k, v in pairs(def.fertility) do
		g[v] = 1
	end
	for k, v in pairs(def.groups) do
		g[k] = v
	end
	
	if not def.no_seed then
		minetest.register_node(":" .. mname .. ":seed_" .. pname, {
			description = def.description,
			tiles = {def.inventory_image},
			inventory_image = def.inventory_image,
			wield_image = def.inventory_image,
			drawtype = "signlike",
			groups = g,
			paramtype = "light",
			paramtype2 = "wallmounted",
			place_param2 = def.place_param2 or nil, -- this isn't actually used for placement
			--walkable = false,
			sunlight_propagates = true,
			selection_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
			},
			fertility = def.fertility,
			sounds = default.node_sound_dirt_defaults({
				dig = {name = "", gain = 0},
				dug = {name = "default_grass_footstep", gain = 0.2},
				place = {name = "default_place_node", gain = 0.25},
			}),
			base_plant = base_plant,
			next_growth_step = 1,
			tier_count = 1,
			groups = g,

			on_place = function(itemstack, placer, pointed_thing)
				local under = pointed_thing.under
				local node = minetest.get_node(under)
				local udef = minetest.registered_nodes[node.name]
				if udef and udef.on_rightclick and
						not (placer and placer:is_player() and
						placer:get_player_control().sneak) then
					return udef.on_rightclick(under, node, placer, itemstack,
						pointed_thing) or itemstack
				end

				return farming_super.place_seed(itemstack, placer, pointed_thing, mname .. ":seed_" .. pname)
			end,
			--next_plant = mname .. ":" .. pname .. "_1",
			on_timer = farming_super.grow_plant,
			minlight = def.minlight,
			maxlight = def.maxlight,
			seed_variants = def.seed_variants,
		})
	end

	if not def.no_harvest then
		-- Register harvest
		minetest.register_craftitem(":" .. mname .. ":" .. pname, {
			description = pname:gsub("^%l", string.upper),
			inventory_image = mname .. "_" .. pname .. ".png",
			groups = {flammable = 2},
		})
	end

	local next_node = {
		[mname .. ":seed_" .. pname] = mname .. ":" .. pname .. "_1_1"
	}
	local stack_height = {
		[mname .. ":seed_" .. pname] = 1
	}
	local last = nil
	local name
	local totalSteps = 0
	for _,numSteps in ipairs(def.steps) do
		totalSteps = totalSteps + numSteps
	end
	print("total steps " .. totalSteps)
	
	local tex_base = mname.."_"..pname
	if def.textures and def.textures.base then
		tex_base = def.textures.base
	end
	
	local step = 1
	for tierCount,numSteps in ipairs(def.steps) do
		
		for tierStep = 1,numSteps do
		
			local ns = step + 1
			if step == totalSteps then
				ns = nil
			end
			
			for tier = 1,tierCount do
				name = mname .. ":" .. pname .. "_"..step.."_"..tier
				
				local dropname = "p"..tierCount.."s"..tierStep.."t"..tier
				local drops = def_drops[dropname] or def.default_drop
				local tex = (def.textures and def.textures[dropname]) or (tex_base.."_"..tierCount.."_"..tierStep.."_"..tier..".png")
				
				minetest.register_node(name, {
					drawtype = "plantlike",
					waving = false,
					tiles = {tex},
					paramtype = "light",
					paramtype2 = def.paramtype2 or nil,
					place_param2 = def.place_param2 or nil,
					walkable = false,
					buildable_to = true,
					drop = drops,
					selection_box = {
						type = "fixed",
						fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
					},
					groups = g,
					sounds = default.node_sound_leaves_defaults(),
					next_growth_step = ns,
					tier_count = tierCount,
					base_plant = base_plant,
					on_timer = farming_super.grow_plant,
					minlight = def.minlight,
					maxlight = def.maxlight,
					-- todo: ondestruct
					after_dig_node = cut_whole_plant,
				})
				
				if last then
					next_node[last] = name
					stack_height[last] = step
				end
				
				last = name

			end
			
			step = step + 1
		end
	end
	
	
	def.next_node = next_node
	def.stack_height = stack_height
	print("def name "..pname)
	farming_super.registered_plants[pname] = def


	--[[ 
	for i = 1, 5 do
		minetest.override_item("default:grass_"..i, {drop = {
			max_items = 1,
			items = {
				{items = {'farming:seed_wheat'},rarity = 5},
				{items = {'default:grass_1'}},
			}
		}})
	end
]]

	if not def.no_seed then

		local old_grass_drops = deepclone(minetest.registered_items["default:junglegrass"].drop)
		print('+++++++++++++++++++++++++++++++++++++++++++')
		table.insert(old_grass_drops.items, 1, {items={mname .. ":seed_" .. pname}, rarity=2})
		table.sort(old_grass_drops.items, function(a, b) return (b.rarity or 0) < (a.rarity or 0) end)
		
		minetest.override_item("default:junglegrass", {drop = old_grass_drops})
 		print(dump(minetest.registered_items["default:junglegrass"]))

	end
	
--  	minetest.override_item("default:junglegrass", {drop = old_grass_drops})
--  
--  	minetest.override_item("default:junglegrass", {drop = {
-- 		max_items = 1,
-- 		items = {
-- 			{items = {mname .. ":seed_" .. pname}},
-- 		--	{items = {'default:junglegrass'}},
-- 		}
-- 	}})
-- 	
	
	

	--[[
	-- Register growing steps
	for i = 1, def.steps do
		local base_rarity = 1
		if def.steps ~= 1 then
			base_rarity =  8 - (i - 1) * 7 / (def.steps - 1)
		end
		local drop = {
			items = {
				{items = {mname .. ":" .. pname}, rarity = base_rarity},
				{items = {mname .. ":" .. pname}, rarity = base_rarity * 2},
				{items = {mname .. ":seed_" .. pname}, rarity = base_rarity},
				{items = {mname .. ":seed_" .. pname}, rarity = base_rarity * 2},
			}
		}
		local nodegroups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1}
		nodegroups[pname] = i

		local next_plant = nil

		if i lt def.steps then
			next_plant = mname .. ":" .. pname .. "_" .. (i + 1)
			lbm_nodes[#lbm_nodes + 1] = mname .. ":" .. pname .. "_" .. i
		end

		minetest.register_node(":" .. mname .. ":" .. pname .. "_" .. i, {
			drawtype = "plantlike",
			waving = 1,
			tiles = {mname .. "_" .. pname .. "_" .. i .. ".png"},
			paramtype = "light",
			paramtype2 = def.paramtype2 or nil,
			place_param2 = def.place_param2 or nil,
			walkable = false,
			buildable_to = true,
			drop = drop,
			selection_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
			},
			groups = nodegroups,
			sounds = default.node_sound_leaves_defaults(),
			next_plant = next_plant,
			on_timer = farming_super.grow_plant,
			minlight = def.minlight,
			maxlight = def.maxlight,
		})
	end
	]]

	--[[
	-- replacement LBM for pre-nodetimer plants
	minetest.register_lbm({
		name = ":" .. mname .. ":start_nodetimer_" .. pname,
		nodenames = lbm_nodes,
		action = function(pos, node)
			tick_again(pos)
		end,
	})
	]]

	-- Return
	local r = {
		seed = mname .. ":seed_" .. pname,
		harvest = mname .. ":" .. pname
	}
	return r
end

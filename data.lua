require("particles")
require("explosions")
require("corpses")

require("sound-util")
require("circuit-connector-sprites")
require("util")
require("__base__.prototypes.entity.circuit-network")

local hit_effects = require("__base__.prototypes.entity.hit-effects")
local item_sounds = require("__base__.prototypes.item_sounds")
local sounds = require("__base__.prototypes.entity.sounds")

local kg = 1000

data:extend({ {
  type = "item",
  name = "heating-tower",
  icon = "__HeatingTower__/graphics/icons/heating-tower.png",
  subgroup = "energy",
  order = "c[heating-tower]",
  inventory_move_sound = item_sounds.steam_inventory_move,
  pick_sound = item_sounds.steam_inventory_pickup,
  drop_sound = item_sounds.steam_inventory_move,
  place_result = "heating-tower",
  stack_size = 20,
  weight = 100 * kg
}, {
  type = "recipe",
  name = "heating-tower",
  energy_required = 10,
  ingredients =
  {
    { type = "item", name = "boiler",    amount = 2 },
    { type = "item", name = "heat-pipe", amount = 5 },
    { type = "item", name = "concrete",  amount = 20 },
  },
  results = { { type = "item", name = "heating-tower", amount = 1 } },
  enabled = false
},
  {
    type                                 = "reactor",
    name                                 = "heating-tower",
    icon                                 = "__HeatingTower__/graphics/icons/heating-tower.png",
    flags                                = { "placeable-neutral", "player-creation" },
    minable                              = { mining_time = 0.5, result = "heating-tower" },
    max_health                           = 500,
    corpse                               = "heating-tower-remnants",
    dying_explosion                      = "heating-tower-explosion",
    surface_conditions                   =
    {
      {
        property = "pressure",
        min = 10
      }
    },
    consumption                          = "40MW",
    neighbour_bonus                      = 0,
    energy_source                        =
    {
      type = "burner",
      fuel_categories = { "chemical" },
      emissions_per_minute = { pollution = 100 },
      effectivity = 2.5,
      fuel_inventory_size = 2,
      burnt_inventory_size = 2,
      light_flicker =
      {
        color = { 0, 0, 0 },
        minimum_intensity = 0.7,
        maximum_intensity = 0.95
      }
    },
    collision_box                        = { { -1.25, -1.25 }, { 1.25, 1.25 } },
    selection_box                        = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    damaged_trigger_effect               = hit_effects.entity(),
    drawing_box_vertical_extension       = 1,

    picture                              =
    {
      layers =
      {
        util.sprite_load("__HeatingTower__/graphics/entity/heating-tower/heating-tower-main", {
          scale = 0.5
        }),
        util.sprite_load("__HeatingTower__/graphics/entity/heating-tower/heating-tower-shadow", {
          scale = 0.5,
          draw_as_shadow = true
        })
      }
    },

    working_light_picture                =
    {
      layers = {
        util.sprite_load("__HeatingTower__/graphics/entity/heating-tower/heating-tower-working-fire", {
          frame_count = 24,
          scale = 0.5,
          blend_mode = "additive",
          draw_as_glow = true,
          animation_speed = 0.333
        }),
        util.sprite_load("__HeatingTower__/graphics/entity/heating-tower/heating-tower-working-light", {
          frame_count = 1,
          repeat_count = 24,
          scale = 0.5,
          blend_mode = "additive",
          draw_as_glow = true
        })
      }
    },

    heat_buffer                          =
    {
      max_temperature = 1000,
      specific_heat = "5MJ",
      max_transfer = "10GW",
      minimum_glow_temperature = 50,
      connections =
      {
        {
          position = { 0, -1 },
          direction = defines.direction.north
        },
        {
          position = { 1, 0 },
          direction = defines.direction.east
        },
        {
          position = { 0, 1 },
          direction = defines.direction.south
        },
        {
          position = { -1, 0 },
          direction = defines.direction.west
        },
      },

      heat_picture = apply_heat_pipe_glow(
        util.sprite_load("__HeatingTower__/graphics/entity/heating-tower/heating-tower-glow", {
          scale = 0.5,
          blend_mode = "additive"
        }))
    },

    connection_patches_connected         =
    {
      sheet = util.sprite_load("__HeatingTower__/graphics/entity/heating-tower/heating-tower-pipes", {
        scale = 0.5,
        variation_count = 4
      })
    },

    connection_patches_disconnected      =
    {
      sheet = util.sprite_load("__HeatingTower__/graphics/entity/heating-tower/heating-tower-pipes-disconnected", {
        scale = 0.5,
        variation_count = 4
      })
    },

    heat_connection_patches_connected    =
    {
      sheet = apply_heat_pipe_glow(
        util.sprite_load("__HeatingTower__/graphics/entity/heating-tower/heating-tower-pipes-heat", {
          scale = 0.5,
          variation_count = 4
        }))
    },

    heat_connection_patches_disconnected =
    {
      sheet = apply_heat_pipe_glow(
        util.sprite_load("__HeatingTower__/graphics/entity/heating-tower/heating-tower-pipes-heat-disconnected", {
          scale = 0.5,
          variation_count = 4
        }))
    },

    open_sound                           = sounds.steam_open,
    close_sound                          = sounds.steam_close,
    working_sound                        =
    {
      sound = { filename = "__HeatingTower__/sound/entity/heating-tower/heating-tower-loop.ogg", volume = 0.5 },
      max_sounds_per_prototype = 2,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },

    default_temperature_signal           = { type = "virtual", name = "signal-T" },
    circuit_wire_max_distance            = reactor_circuit_wire_max_distance,
    circuit_connector                    = circuit_connector_definitions["heating-tower"]
  },
  {
    type = "technology",
    name = "heating-tower",
    icon = "__HeatingTower__/graphics/technology/heating-tower.png",
    icon_size = 256,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "heating-tower"
      },
      {
        type = "unlock-recipe",
        recipe = "heat-pipe"
      },
      {
        type = "unlock-recipe",
        recipe = "heat-exchanger"
      },
      {
        type = "unlock-recipe",
        recipe = "steam-turbine"
      }
    },
    prerequisites = { "production-science-pack" },
    unit =
    {
      count = 250,
      ingredients =
      {
        { "automation-science-pack", 1 },
        { "logistic-science-pack",   1 },
        { "chemical-science-pack",   1 },
        { "production-science-pack", 1 }
      },
      time = 60
    }
  } })

circuit_connector_definitions["heating-tower"] = circuit_connector_definitions.create_single
    (
      universal_connector_template,
      { variation = 30, main_offset = util.by_pixel(-12, 17), shadow_offset = util.by_pixel(10, 30), show_shadow = false }
    )

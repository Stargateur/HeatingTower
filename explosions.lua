require("util")
require("transport-belts")
require("particles")

local sounds = require("__base__.prototypes.entity.sounds")
local explosion_animations = require("__base__/prototypes/entity/explosion-animations")

data:extend({ {
  type = "explosion",
  name = "heating-tower-explosion",
  icon = "__HeatingTower__/graphics/icons/heating-tower.png",
  flags = { "not-on-map" },
  hidden = true,
  subgroup = "energy-explosions",
  order = "c[heating-tower]",
  height = 0,
  animations = explosion_animations.medium_explosion(),
  smoke = "smoke-fast",
  smoke_count = 2,
  smoke_slow_down_factor = 1,
  sound = sounds.medium_explosion,
  created_effect =
  {
    type = "direct",
    action_delivery =
    {
      type = "instant",
      target_effects =
      {
        {
          type = "create-particle",
          repeat_count = 13,
          probability = 1,
          particle_name = "heating-tower-particle-big",
          offsets = { { 0, 0 } },
          offset_deviation = {
            left_top = { -0.9805, -0.9805 },
            right_bottom = { 0.9805, 0.9805 }
          },
          initial_height = 0.2,
          initial_height_deviation = 0.3,
          initial_vertical_speed = 0.058,
          initial_vertical_speed_deviation = 0.05,
          speed_from_center = 0.03,
          speed_from_center_deviation = 0.05
        },
        {
          type = "create-particle",
          repeat_count = 12,
          repeat_count_deviation = 0,
          probability = 1,
          affects_target = false,
          show_in_tooltip = false,
          particle_name = "oil-refinery-metal-particle-medium",
          offsets = {
            { 0, 0 }
          },
          offset_deviation = {
            left_top = { -0.9805, -0.9805 },
            right_bottom = { 0.9805, 0.9805 }
          },
          tile_collision_mask = nil,
          initial_height = 0.5,
          initial_height_deviation = 0.3,
          initial_vertical_speed = 0.058,
          initial_vertical_speed_deviation = 0.05,
          speed_from_center = 0.04,
          speed_from_center_deviation = 0.05,
          frame_speed = 1,
          frame_speed_deviation = 0,
          rotate_offsets = false
        },
        {
          type = "create-particle",
          repeat_count = 14,
          repeat_count_deviation = 0,
          probability = 1,
          affects_target = false,
          show_in_tooltip = false,
          particle_name = "heating-tower-particle-medium",
          offset_deviation = {
            left_top = { -0.5, -0.5 },
            right_bottom = { 0.5, 0.5 }
          },
          tile_collision_mask = nil,
          initial_height = 1.1,
          initial_height_deviation = 0.7,
          initial_vertical_speed = 0.1,
          initial_vertical_speed_deviation = 0.07,
          speed_from_center = 0.03,
          speed_from_center_deviation = 0.005,
          frame_speed = 1,
          frame_speed_deviation = 0,
          rotate_offsets = false
        },
        {
          type = "create-particle",
          repeat_count = 10,
          repeat_count_deviation = 0,
          probability = 1,
          affects_target = false,
          show_in_tooltip = false,
          particle_name = "metal-particle-small",

          offset_deviation = {
            left_top = { -0.5, -0.5 },
            right_bottom = { 0.5, 0.5 }
          },
          tile_collision_mask = nil,
          initial_height = 1.0,
          initial_height_deviation = 0.2,
          initial_vertical_speed = 0.1,
          initial_vertical_speed_deviation = 0.05,
          speed_from_center = 0.04,
          speed_from_center_deviation = 0.05,
          frame_speed = 1,
          frame_speed_deviation = 0,
          rotate_offsets = false
        }
      }
    }
  }
} })

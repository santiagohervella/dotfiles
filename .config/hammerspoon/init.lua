-- To stop complaints about missing globals hs
---@diagnostic disable: undefined-global

-- require("rcmd")  -- Original implementation
require("rcmd-v2")  -- New high-performance implementation

-- Prevent the display from ever automatically going to sleep
-- https://www.hammerspoon.org/docs/hs.caffeinate.html#set
hs.caffeinate.set("displayIdle", true, true)

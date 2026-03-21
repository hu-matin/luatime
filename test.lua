-- test.lua
-- Simple test script for luatime module

package.path = package.path .. ";./?.lua"
local luatime = require("init")

print("Testing luatime module v" .. luatime._VERSION)

-- Test time()
local t = luatime.time()
print("Current time:", t)

-- Test sleep()
print("Sleeping for 1 second...")
luatime.sleep(1)
print("Woke up!")

-- Test localtime()
local lt = luatime.localtime()
print("Local time:", lt.year, lt.month, lt.day, lt.hour, lt.min, lt.sec)

-- Test strftime()
local formatted = luatime.strftime("%Y-%m-%d %H:%M:%S", lt)
print("Formatted time:", formatted)

-- Test strptime()
local parsed = luatime.strptime("2023-12-25 15:30:45", "%Y-%m-%d %H:%M:%S")
print("Parsed time:", parsed.year, parsed.month, parsed.day)

-- Test ns functions
print("Time in ns:", luatime.time_ns())

-- Test timezone
print("Timezone:", luatime.timezone)
print("TZ name:", luatime.tzname[1])

print("All tests passed!")
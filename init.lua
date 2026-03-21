-- init.lua
-- Author: Matin
-- Cross-platform Python-style `time` module for Lua

local luatime = {}

luatime._VERSION = "luatime.lua 1.1-1"
luatime.__author = "Matin"



local function struct_time(tbl)
    return {
        year   = tbl.year or tbl.tm_year,
        month  = tbl.month or tbl.tm_mon,
        day    = tbl.day or tbl.tm_mday,
        hour   = tbl.hour or tbl.tm_hour,
        min    = tbl.min or tbl.tm_min,
        sec    = tbl.sec or tbl.tm_sec,
        wday   = tbl.wday or tbl.tm_wday,
        yday   = tbl.yday or tbl.tm_yday,
        isdst  = tbl.isdst or tbl.tm_isdst
    }
end



-- sleep(seconds)
function luatime.sleep(sec)
    local t0 = os.clock()
    while os.clock() - t0 < sec do end
end

-- time() → Unix timestamp
function luatime.time()
    return os.time()
end

-- localtime([sec])
function luatime.localtime(sec)
    sec = sec or os.time()
    local t = os.date("*t", sec)
    return struct_time(t)
end

-- gmtime([sec])
function luatime.gmtime(sec)
    sec = sec or os.time()
    local t = os.date("!*t", sec)
    t.isdst = false
    return struct_time(t)
end

-- mktime(struct_time)
function luatime.mktime(tbl)
    return os.time {
        year  = tbl.year,
        month = tbl.month,
        day   = tbl.day,
        hour  = tbl.hour or 0,
        min   = tbl.min or 0,
        sec   = tbl.sec or 0
    }
end


-- strftime(format, struct_time)
function luatime.strftime(format, tbl)
    return os.date(format, luatime.mktime(tbl))
end

-- ctime([sec])
function luatime.ctime(sec)
    sec = sec or os.time()
    return os.date("%c", sec)
end

-- asctime(struct_time)
function luatime.asctime(tbl)
    return luatime.strftime("%c", tbl)
end

-- perf_counter()
local perf_start = os.clock()
function luatime.perf_counter()
    return os.clock() - perf_start
end

-- monotonic()
function luatime.monotonic()
    return os.clock()
end

-- process_time()
function luatime.process_time()
    return os.clock()
end

-- Timezone information
local tz_info = os.date("*t")
luatime.timezone = tz_info.isdst and (tz_info.hour * 3600 + tz_info.min * 60) or 0  -- approximate
luatime.altzone = luatime.timezone  -- Lua doesn't distinguish
luatime.daylight = tz_info.isdst and 1 or 0
luatime.tzname = {os.date("%Z"), os.date("%Z")}  -- approximate

-- strptime(string, format)
function luatime.strptime(string, format)
    -- Simple implementation: assume format is "%Y-%m-%d %H:%M:%S"
    -- For full compatibility, would need a proper parser
    local year, month, day, hour, min, sec = string:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
    if not year then
        error("Unsupported format or string")
    end
    return struct_time{
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(min),
        sec = tonumber(sec)
    }
end

-- time_ns() - nanosecond version (approximate)
function luatime.time_ns()
    return math.floor(luatime.time() * 1e9)
end

-- monotonic_ns() - nanosecond version (approximate)
function luatime.monotonic_ns()
    return math.floor(luatime.monotonic() * 1e9)
end

-- perf_counter_ns() - nanosecond version (approximate)
function luatime.perf_counter_ns()
    return math.floor(luatime.perf_counter() * 1e9)
end

-- process_time_ns() - nanosecond version (approximate)
function luatime.process_time_ns()
    return math.floor(luatime.process_time() * 1e9)
end

-- get_clock_info(name)
function luatime.get_clock_info(name)
    -- Simplified: return basic info
    local info = {
        adjustable = false,
        implementation = "Lua os.clock",
        monotonic = true,
        resolution = 0.01
    }
    return info
end

-- sleep_ms(milliseconds) (optional helper)
function luatime.sleep_ms(ms)
    luatime.sleep(ms / 1000)
end

return luatime

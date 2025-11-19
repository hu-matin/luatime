-- luatime.lua
-- Author: matin
-- Cross-platform Python-style `time` module for Lua

local luatime = {}

luatime._VERSION = "luatime.lua 1.0"
luatime.__author = "matin"


local luatime = {}



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

-- sleep_ms(milliseconds) (optional helper)
function luatime.sleep_ms(ms)
    luatime.sleep(ms / 1000)
end

return luatime

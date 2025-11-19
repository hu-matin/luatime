# **luatime — Python‑style Time Module for Lua**


This project was created because I wanted Lua developers to experience the **same simplicity and power** of Python’s built‑in `time` module. The goal of this library is to give you **function names, behaviors, inputs, and outputs identical to Python’s `time` module`**, but fully implemented in **pure Lua**, working on **all operating systems**.

If you know Python’s `time`, then you already know this module.

## Installation

You can install this module with LuaRocks forever.
```lua
luarocks install luatime
```

---

## **Module Name**

The module must be required exactly like Python with one difference just in its name:

```lua
local luatime = require("luatime")
```

---

## **Full Documentation:**

All function names and parameters match Python’s `time` module.

## **1. luatime.time()**

Returns the current time in seconds since the epoch (UNIX timestamp).

### Example

```lua
local now = luatime.time()
print(now)
```

---

## **2. luatime.sleep(secs)**

Pauses execution for the given number of seconds.

### Example

```lua
luatime.sleep(2)
print("2 seconds passed")
```

---

## **3. luatime.monotonic()**

Returns a clock value that always increases. Cannot go backward.

### Example

```lua
local t1 = luatime.monotonic()
luatime.sleep(1)
local t2 = luatime.monotonic()
print(t2 - t1)
```

---

## **4. luatime.perf_counter()**

High‑precision performance timer (alias of `monotonic`).

### Example

```lua
local t = luatime.perf_counter()
for i = 1, 1e6 do end
print(luatime.perf_counter() - t)
```

---

## **5. luatime.process_time()**

Returns CPU time used by the program.

### Example

```lua
local t = luatime.process_time()
for i = 1, 5e6 do end
print(luatime.process_time() - t)
```

---

## **6. luatime.ctime([secs])**

Converts a timestamp to a human‑readable string.

### Example

```lua
print(luatime.ctime())
print(luatime.ctime(0))
```

---

## **7. luatime.localtime([secs])**

Returns a table representing the local time.

### Example

```lua
local t = luatime.localtime()
print(t.year, t.month, t.day)
```

---

## **8. luatime.gmtime([secs])**

Returns a table representing UTC time.

### Example

```lua
local t = luatime.gmtime()
print(t.hour)
```

---

## **9. luatime.mktime(tbl)**

Converts a time table back into a timestamp.

### Example

```lua
local ts = luatime.mktime{year=2025, month=1, day=1, hour=0}
print(ts)
```

---

## **10. luatime.strftime(fmt, [tuple])**

Formats a time structure into a string.

### Example

```lua
print(luatime.strftime("%Y-%m-%d %H:%M:%S", luatime.localtime()))
```

---

## **Comparison Table — Python vs Lua Version**

| Python Function | Lua Function | Same Behavior |
|-----------------|-----------------------------|:--:|
| time()          | luatime.time()                 | ✔️ |
| sleep()         | luatime.sleep()                | ✔️ |
| monotonic()     | luatime.monotonic()            | ✔️ |
| perf_counter()  | luatime.perf_counter()         | ✔️ |
| process_time()  | luatime.process_time()         | ✔️ |
| ctime()         | luatime.ctime()                | ✔️ |
| localtime()     | luatime.localtime()            | ✔️ |
| gmtime()        | luatime.gmtime()               | ✔️ |
| mktime()        | luatime.mktime()               | ✔️ |
| strftime()      | luatime.strftime()             | ✔️ |

---

## **Final Note**

This library exists so that developers who already know Python’s `time` can use identical functions in Lua. My goal was to make your transition between languages easier, cleaner, and more enjoyable.

Just tell me ❤️

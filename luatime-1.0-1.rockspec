package = "luatime"
version = "1.0-1"

source = {
    url = "git+https://github.com/hu-matin/luatime"
}

description = {
    summary = "Python's time module implemented for Lua",
    detailed = "A full compatibility implementation of Python's time module written by Matin.",
    license = "MIT",
    maintainer = "Matin",
    homepage = "https://github.com/hu-matin/luatime"
}

dependencies = {
}

build = {
    type = "builtin",
    modules = {
        luatime = "luatime/init.lua"
    }
}


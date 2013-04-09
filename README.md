#LuaRock "set"
Straightforward Set library for Lua

##Install
Set is a listed [LuaRock](http://luarocks.org/repositories/rocks/). Install using [LuaRocks](http://www.luarocks.org/): `luarocks install set`

###Dependencies
Set depends on [Lua 5.2](http://www.lua.org/download.html). [lunitx](https://github.com/dcurrie/lunit) is needed to run the tests and will be installed if not present

##Usage
Start off with
```lua
require("luarocks.loader")
local Set = require("Set")
```
Then, to create a set:
```lua
local ilike = Set:new()
```
to add items to a set:
```lua
ilike:add("apples")
ilike:add("bananas")
```
or, we could have done:
```lua
local ilike = Set:new({"apples", "bananas"})
```
Let's have another set:
```lua
local ulike = Set:new({"apples", "strawberries"})
```
Then we can:
```lua
local welike     = ilike + ulike -- union:        apples, bananas, strawberries
local webothlike = ilike * ulike -- intersection: apples
local udontlike  = ilike - ulike -- subtraction:  bananas
```
Lastly, some conveniences:
```lua
ilike:len()  -- 2
local somethingilike = ilike:anelement()
print(ilike) -- {"apples", "bananas"}
```

##Tests
See `./tst/init.lua`

##License
MIT; see `./doc/LICENSE`

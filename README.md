#LuaRock "set"
Straightforward Set library for Lua

###License
MIT; see ./doc/LICENSE

###Usage
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
print(ilike) -- {"apples", "bananas"}
```

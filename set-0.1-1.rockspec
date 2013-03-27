package = "set"
version = "0.1-1"
source = {
  url = "git://github.com/wscherphof/lua-set.git",
  dir = "set-0.1",
  branch = "v0.1"
}
description = {
  summary = "Straightforward Set library",
  detailed = [[
    Creating and manipulating sets, including + (union), - (substraction), * (intersection), and tostring()
  ]],
  homepage = "http://wscherphof.github.com/lua-set/",
  license = "MIT"
}
dependencies = {
  "lua >= 5.2"
}
build = {
  type = "builtin",
  modules = {
    Set = "Set.lua"
  }
}
package = "set"
version = "0.2.1-2"
source = {
  url = "git://github.com/wscherphof/lua-set.git",
  branch = "v0.2.1"
}
description = {
  summary = "Straightforward Set library",
  detailed = [[
    Creating and manipulating sets, including + (union), - (subtraction), * (intersection), len(), and tostring()
  ]],
  homepage = "http://wscherphof.github.io/lua-set/",
  license = "LGPL+"
}
dependencies = {
  "lua >= 5.1",
  "lunitx >= 0.6"
}
build = {
  type = "builtin",
  copy_directories = {"doc", "tst"},
  modules = {
    ["Set.init"] = "src/Set/init.lua"
  }
}

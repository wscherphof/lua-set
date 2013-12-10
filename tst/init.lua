require("luarocks.loader")
-- Omit next line in actual module clients; it's only to support development of the module itself
package.path = "../src/?/init.lua;" .. package.path

local lunitx = require("lunitx")
module("test_set", lunitx.testcase, package.seeall)

local Set = require("Set")

function test_new_copy_idx()
  local orig, copy
  orig = Set:new({1, 2, 3})
  copy = Set:new(orig)
  copy[2] = nil
  assert(orig[1])
  assert(orig[2])
  assert(orig[3])
  assert(copy[1])
  assert_nil(copy[2])
  assert(copy[3])
end

function test_new_copy_obj()
  local orig, copy
  orig = Set:new({"a", "b", "c"})
  copy = Set:new(orig)
  copy["b"] = nil
  assert(orig["a"])
  assert(orig["b"])
  assert(orig["c"])
  assert(copy["a"])
  assert_nil(copy["b"])
  assert(copy["c"])
end

function test_tostring()
  assert_equal(Set.mt.__tostring(Set:new({1, 2, 3})), "{1, 2, 3}")
  assert_equal(9,  #Set.mt.__tostring(Set:new({"a", "b", "c"})), "{a, b, c}               (or in a different permutation)")
  assert_equal(23, #Set.mt.__tostring(Set:new({ {} })),          "{table: 0x7ff498c52ea0} (but a different same-length key)")
end

function test_new_len()
  local a, b, c, d = 1, "1", "one", {}
  local set = Set:new({a, b, c, d})
  assert(set[a], "set[a]")
  assert(set[b], "set[b]")
  assert(set[c], "set[c]")
  assert(set[d], "set[d]")
  assert_equal(4, set:len(), "{a, b, c, d}")

  assert_equal(0, Set:new():len(), "")
  assert_equal(0, Set:new({}):len(), "{}")

  assert_equal(1, Set:new(1):len(), "1")
  assert_equal(1, Set:new({1}):len(), "{1}")
  assert_equal(1, Set:new("1"):len(), "'1'")

  assert_equal(2, Set:new({1, 2}):len(), "{1, 2}")
  assert_equal(2, Set:new({1, 2, 1}):len(), "{1, 2, 1}")
  assert_equal(2, Set:new({"1", "2"}):len(), "{'1', '2'}")
  assert_equal(2, Set:new({"1", "2", "1"}):len(), "{'1', '2', '1'}")

  assert_equal(2, Set:new(Set:new({1, 2})):len(), "Set:new({1, 2})")
  assert_equal(2, Set:new(Set:new({"1", "2"})):len(), "Set:new({'1', '2'})")
end

function test_add_remove()
  assert_equal(0, Set:new():add():len())
  assert_equal(0, Set:new():remove():len())
  assert_equal(0, Set:new():remove(1):len())

  assert_equal(1, Set:new():add(1):len())
  assert_equal(1, Set:new(1):add():len())
  assert_equal(1, Set:new(1):add(1):len())
  assert_equal(2, Set:new(1):add(2):len())
  
  assert_equal(0, Set:new(1):remove(1):len())
  assert_equal(1, Set:new({1, 2}):remove(1):len())
  assert_equal(1, Set:new({1, 2}):remove(2):len())

  local t = {1, 2}
  assert_equal(1, Set:new():add(t):len())
  assert_equal(2, Set:new(t):add(1):len())
  assert_equal(2, Set:new(t):add(2):len())
  assert_equal(3, Set:new(t):add(3):len())
  assert_equal(3, Set:new(t):add(t):len())
  -- 
  assert_equal(0, Set:new():add(t):remove(t):len())
  assert_equal(2, Set:new(t):remove(t):len())
  assert_equal(1, Set:new(t):remove(1):len())
  assert_equal(1, Set:new(t):remove(2):len())
  assert_equal(2, Set:new(t):remove(3):len())
end

function test_anelement()
  local t = {1, "one", "", "nil", {}, {1, 2}}
  assert( Set:new(t)[ Set:new(t):anelement() ] )
end

function test_union()
  assert( (Set:new("a") + Set:new("b")).a )
  assert( (Set:new("a") + Set:new("b")).b )
  assert( (Set:new(   ) + Set:new("b")).b )
  assert( (Set:new("a") + Set:new(   )).a )

  assert( (Set:new("a") + "b").a )
  assert( (Set:new("a") + "b").b )
  assert( (Set:new(   ) + "b").b )
  assert( (Set:new("a") + nil).a )

  assert( ("b" + Set:new("a")).a )
  assert( ("b" + Set:new("a")).b )
  assert( ("b" + Set:new(   )).b )
  assert( (nil + Set:new("a")).a )

  assert( ("b" + Set:new() + "a").a )
  assert( ("b" + Set:new() + "a").b )
  assert( ("b" + Set:new() + nil).b )
  assert( (nil + Set:new() + "a").a )

  assert( (Set:new() + "b" + "a").a )
  assert( (Set:new() + "b" + "a").b )
  assert( (Set:new() + "b" + nil).b )
  assert( (Set:new() + nil + "a").a )

  assert_error("attempt to perform arithmetic on a string value", function()
    assert( ("b" + "a" + Set:new()).a )
  end)
end

function test_subtract()
  assert_nil( (Set:new(1)      - Set:new(1))      [1] )
  assert_nil( (Set:new({1, 2}) - Set:new({2, 3})) [2] )
end

function test_intersection()
  assert(     (Set:new(1)         * Set:new(1))         [1] )
  assert(     (Set:new({1, 2, 3}) * Set:new({2, 3, 4})) [2] )
  assert(     (Set:new({1, 2, 3}) * Set:new({2, 3, 4})) [3] )
  assert_nil( (Set:new({1, 2, 3}) * Set:new({2, 3, 4})) [1] )
  assert_nil( (Set:new({1, 2, 3}) * Set:new({2, 3, 4})) [4] )
end

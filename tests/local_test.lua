local http_client = require('http.client')
local json = require('json')
local send_route = 'http://localhost:8081/kv'

local test_examples1 = {{ key = 'test1', value = 1 }, { key = 'test2', value = "str" }, 
                        { key = 'test3', value = { a = 1, b = 2 } }, 
                        { key = 'test4', value = {123, 515, 2543}},
                        { key = 5 }, { key = 'test6'}, { key = 'test7', value = 0 }}

local test_examples2 = {{ value = '234' }, {value = 234}, {notvalue = 1}}


assert(http_client.post(send_route, json.encode(test_examples1[1])).status == 200)
assert(http_client.post(send_route, json.encode(test_examples1[2])).status == 200)
assert(http_client.post(send_route, json.encode(test_examples1[3])).status == 200)
assert(http_client.post(send_route, json.encode(test_examples1[3])).status == 409)
assert(http_client.post(send_route, json.encode(test_examples1[4])).status == 200)
assert(http_client.post(send_route, json.encode(test_examples1[5])).status == 400)
assert(http_client.post(send_route, json.encode(test_examples1[6])).status == 400)
assert(http_client.post(send_route, json.encode(test_examples1[7])).status == 200)

print("OK")

assert(http_client.get(send_route..'/'..test_examples1[1].key).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[2].key).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[3].key).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[4].key).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[6].key).status == 404)
assert(http_client.get(send_route..'/'..test_examples1[7].key).status == 200)

print("OK")

assert(http_client.get(send_route..'/'..test_examples1[1].key).body == json.encode(test_examples1[1].value))
assert(http_client.get(send_route..'/'..test_examples1[2].key).body == json.encode(test_examples1[2].value))
assert(http_client.get(send_route..'/'..test_examples1[3].key).body == json.encode(test_examples1[3].value))
assert(http_client.get(send_route..'/'..test_examples1[4].key).body == json.encode(test_examples1[4].value))
assert(http_client.get(send_route..'/'..test_examples1[7].key).body == json.encode(test_examples1[7].value))

assert(http_client.put(send_route..'/'..test_examples1[1].key, json.encode(test_examples2[1])).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[1].key).body == json.encode(test_examples2[1].value))
assert(http_client.put(send_route..'/'..test_examples1[1].key, json.encode(test_examples2[2])).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[1].key).body == json.encode(test_examples2[2].value))
assert(http_client.put(send_route..'/'..test_examples1[1].key, json.encode(test_examples2[2])).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[1].key).body == json.encode(test_examples2[2].value))
assert(http_client.put(send_route..'/'..test_examples1[6].key, json.encode(test_examples2[2])).status == 404)
assert(http_client.put(send_route..'/'..test_examples1[6].key, json.encode(test_examples2[3])).status == 400)
assert(http_client.get(send_route..'/'..test_examples1[6].key).status == 404)

print("OK")

assert(http_client.delete(send_route..'/'..test_examples1[1].key).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[1].key).status == 404)
assert(http_client.post(send_route, json.encode(test_examples1[1])).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[1].key).status == 200)
assert(http_client.delete(send_route..'/'..test_examples1[1].key).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[1].key).status == 404)
assert(http_client.delete(send_route..'/'..test_examples1[6].key).status == 404)

assert(http_client.delete(send_route..'/'..test_examples1[2].key).status == 200)
assert(http_client.delete(send_route..'/'..test_examples1[3].key).status == 200)
assert(http_client.delete(send_route..'/'..test_examples1[4].key).status == 200)
assert(http_client.delete(send_route..'/'..test_examples1[7].key).status == 200)

assert(http_client.post(send_route, json.encode(test_examples1[1])).status == 200)
assert(http_client.post(send_route, json.encode(test_examples1[2])).status == 200)
assert(http_client.post(send_route, json.encode(test_examples1[3])).status == 200)
assert(http_client.post(send_route, json.encode(test_examples1[3])).status == 409)
assert(http_client.post(send_route, json.encode(test_examples1[4])).status == 200)
assert(http_client.post(send_route, json.encode(test_examples1[5])).status == 400)
assert(http_client.post(send_route, json.encode(test_examples1[6])).status == 400)
assert(http_client.post(send_route, json.encode(test_examples1[7])).status == 200)

print("OK")

assert(http_client.get(send_route..'/'..test_examples1[1].key).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[2].key).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[3].key).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[4].key).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[6].key).status == 404)
assert(http_client.get(send_route..'/'..test_examples1[7].key).status == 200)

assert(http_client.get(send_route..'/'..test_examples1[1].key).body == json.encode(test_examples1[1].value))
assert(http_client.get(send_route..'/'..test_examples1[2].key).body == json.encode(test_examples1[2].value))
assert(http_client.get(send_route..'/'..test_examples1[3].key).body == json.encode(test_examples1[3].value))
assert(http_client.get(send_route..'/'..test_examples1[4].key).body == json.encode(test_examples1[4].value))
assert(http_client.get(send_route..'/'..test_examples1[7].key).body == json.encode(test_examples1[7].value))

assert(http_client.put(send_route..'/'..test_examples1[1].key, json.encode(test_examples2[1])).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[1].key).body == json.encode(test_examples2[1].value))
assert(http_client.put(send_route..'/'..test_examples1[1].key, json.encode(test_examples2[2])).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[1].key).body == json.encode(test_examples2[2].value))
assert(http_client.put(send_route..'/'..test_examples1[1].key, json.encode(test_examples2[2])).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[1].key).body == json.encode(test_examples2[2].value))
assert(http_client.put(send_route..'/'..test_examples1[6].key, json.encode(test_examples2[2])).status == 404)
assert(http_client.put(send_route..'/'..test_examples1[6].key, json.encode(test_examples2[3])).status == 400)
assert(http_client.get(send_route..'/'..test_examples1[4].key).body == json.encode(test_examples1[4].value))

print("OK")

assert(http_client.delete(send_route..'/'..test_examples1[1].key).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[1].key).status == 404)
assert(http_client.post(send_route, json.encode(test_examples1[1])).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[1].key).status == 200)
assert(http_client.delete(send_route..'/'..test_examples1[1].key).status == 200)
assert(http_client.get(send_route..'/'..test_examples1[1].key).status == 404)
assert(http_client.delete(send_route..'/'..test_examples1[6].key).status == 404)

assert(http_client.delete(send_route..'/'..test_examples1[2].key).status == 200)
assert(http_client.delete(send_route..'/'..test_examples1[3].key).status == 200)
assert(http_client.delete(send_route..'/'..test_examples1[4].key).status == 200)
assert(http_client.delete(send_route..'/'..test_examples1[7].key).status == 200)

print("OK")

for i = 1, 100 do
    assert(http_client.post(send_route, json.encode({ key = 'test'..i, value = i })).status == 200)
end

for i = 100, 1, -1 do
    assert(http_client.get(send_route..'/test'..i).body == json.encode(i))
    assert(http_client.delete(send_route..'/test'..i).status == 200)
end

print("Tests finished, OK")
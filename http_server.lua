local json = require('json')
--get Heroku $PORT or choose local port manually
local host_port = os.getenv("PORT") or 8081
local route_name = '/kv'


box.cfg{log_format = 'plain', log_level = 6, log = 'logs.txt'}
box.once('init', function()
    box.schema.create_space('base')
    box.space.base:create_index(
        "primary", {type = 'hash', parts = {1, 'string'}}
    )
    end
)


local function get_key_from_path(path)
    --"/route/key"
    return path:sub(string.len(route_name..'/') + 1)
end

local function post_handler(request)
    local body = request:json()
    local key = body["key"]
    local value = body["value"]

    if type(key) ~= "string" or not value then
        return {status = 400}
    end

    if pcall(box.space.base.insert, box.space.base, {key, value}) then
        return {status = 200}
    else
        return {status = 409}
    end
end

local function put_handler(request)
    local body = request:json()
    local key = get_key_from_path(request.path)
    local value = body["value"]

    if not value then
        return {status = 400}
    end

    if box.space.base:update({key}, {{'=', 2, value}}) then
        return {status = 200}
    else
        return {status = 404}
    end 
end

local function get_handler(request)
    local key = get_key_from_path(request.path)

    local result = box.space.base:get(key)
    if result then
        return {status = 200, body = json.encode(result[2])}
    else
        return {status = 404}
    end
end

local function delete_handler(request)
    local key = get_key_from_path(request.path)

    if box.space.base:delete(key) then
        return {status = 200}
    else
        return {status = 404}
    end
end


local server = require('http.server').new(nil, host_port)
server:route({ path = route_name,          method = "POST"   }, post_handler  )
server:route({ path = route_name..'/:key', method = "PUT"    }, put_handler   )
server:route({ path = route_name..'/:key', method = "GET"    }, get_handler   )
server:route({ path = route_name..'/:key', method = "DELETE" }, delete_handler)
server:start()
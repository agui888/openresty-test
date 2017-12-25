-- openresty 本地cache 所有work 共享的

local function getCache(key)
    local cache_ngx = ngx.shared.my_cache
    local value  = cache_ngx:get(key)
    return value
end

local function setCache(key,value,exptime)
    if not exptime then
        exptime = 0
    end
    local cache_ngx = ngx.shared.my_cache
    local succ, err,forcible  = cache_ngx:set(key,value,exptime)
    return succ,err
end

local function incrNum(key ,num)
    --incr 之前必须要有这个key 才行,否则incr 函数调用也是无效的
    local value = getCache(key)
    if not  value then
        setCache(key,1)
    end
    if not num then
        num =1
    end
    local cache_ngx = ngx.shared.my_cache
    local newvalue  = cache_ngx:incr(key,num)
    return newvalue
end


local succ,err  = setCache("ajun","hello jufeng!!!")
if succ then
    ngx.say("succ -> ",succ)
else
    ngx.say("err -> ",err)
end

local value = getCache("ajun")
ngx.say("ajun -> ",value)
local incr_value = incrNum("HI",1)
if not incr_value then
    ngx.say("incr err -> ",err)
else
    ngx.say("incr_value -> ",incr_value)
end

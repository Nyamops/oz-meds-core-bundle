---@param T table
---@return number
function tableLength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

---@return boolean
---@param e any
---@param t table
function in_table (e, t)
    for _, v in pairs(t) do
        if (v == e) then
            return true
        end
    end

    return false
end

---@param child table
---@param parent table
---@return void
function extend (child, parent)
    for k, v in pairs(parent) do
        child[k] = v
    end
end

function unpack (t, i)
    i = i or 1
    if t[i] ~= nil then
        return t[i], unpack(t, i + 1)
    end
end

---@return string
function uniqid()
    local timestamp = os.time();
    local random = math.random();
    local random2 = math.random(10000000, 99999999);
    local microtime = timestamp + random;
    local md5 = string.format("%8x%06x", math.floor(microtime), (microtime - math.floor(microtime)) * 1000000);
    md5 = md5 .. "." .. random2;
    return md5;
end


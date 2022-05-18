args = {...}

-- Computer Craft Code Catalog

local function fetchFile(path)
    local cacheBuster = ("%x"):format(math.random(0, 2 ^ 30))
    local url = path .. "?cb=" .. cacheBuster
    local content = http.get(url)
    return content
end

local function fetchPath(name)
    local cacheBuster = ("%x"):format(math.random(0, 2 ^ 30))
    local url = "https://codecatalog.cc/" .. filename .. "?cb=" .. cacheBuster
    local path = http.get(url)
    return path
end

local function fetch(name)
    path = fetchPath(name)
    if path == nil then
        return nil
    else
        return fetchFile(path)
    end
end

function load(name)
    script = fetch(name)
    if script ~= nil then
        return os.loadString(script)
    else
        return nil
    end
end

name = args[1]
if name ~= nil then
    load(name)
end

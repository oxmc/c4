-- Variables
args = {...}

C4_URL = "https://raw.githubusercontent.com/oxmc/c4/main/c4.lua"
CATALOG_URL = "https://raw.githubusercontent.com/oxmc/c4/main/catalog.cc"

-- Computer Craft Code Catalog
local function addCacheBusterToURL(url)
    local cacheBuster = ("%x"):format(math.random(0, 2 ^ 30))
    local cacheBustedURL = url .. "?cb=" .. cacheBuster
    return cacheBustedURL
end

local function fetchContentAtURL(url)
    local request = http.get(addCacheBusterToURL(url))
    if (request == nil) then
        print('cannot fetch content at URL. Unable to request ' .. url)
        return nil
    end
    local content = request.readAll()
    return content
end

local function fetchCatalog()
    local content = fetchContentAtURL(CATALOG_URL)
    if content == nil then
        print('cannot fetch catalog')
        return nil
    end
    local catalog = textutils.unserialize(content)
    if catalog == nil then
        print('cannot fetch catalog. Unable to unserialize content')
        print('--------')
        print(content)
        print('--------')
        return nil
    end
    return catalog
end

local function getURLFromCatalog(name)
    local catalog = fetchCatalog()
    if catalog == nil then
        print('cannot get URL from catalog. catalog is nil')
        return nil
    end
    return catalog[name]
end

local function fetchContentFromCatalog(name)
    url = getURLFromCatalog(name)
    if url == nil then
        print('cannot fetch content from catalog. URL is nil')
        return nil
    end
    return fetchContentAtURL(url)
end

local function loadAPIFromCatalog(name)
    local content = fetchContentFromCatalog(name)
    if content == nil then
        print('cannot load API from catalog. content is nil')
        return nil
    end
    local file = fs.open(".c4/"..name, "w")
    if file == nil then
        print('cannot load API from catalog. Unable to open file ' .. name)
        return nil
    end
    file.write(content)
    file.close()
    --if name == "c4" then
        --shell.run("move .c4/c4 c4")
    --end
    os.loadAPI(".c4/"..name)
end

function loadAPI(name)
    local lapi = loadAPIFromCatalog(name)
    print("loading " .. name .. "...")
    if lapi == true then
      print("... done loading " .. name .. "!")
    else
      print("Unable to load" .. name .. "!")
    end
end

local function updateC4()
    local content = fetchContentAtURL(C4_URL)
    local file = fs.open("c4", "w")
    if file == nil then
        return nil
    end
    file.write(content)
    file.close()
end
updateC4()

mode = args[1]
name = args[2]
if name ~= nil then
    loadAPI(name)
else
    print("Usage: c4 <mode> <app or lib name>")
    print("c4 install github")
end

args = {...}

local function updateC4()
    local request = http.get(("https://raw.githubusercontent.com/brooswit/c4/main/c4.lua?cb=%x"):format(math.random(0, 2 ^ 30)))
    local file = fs.open("c4", "w")
    file.write(request.readAll())
    file.close()
end
updateC4()

CATALOG_URL = "https://raw.githubusercontent.com/brooswit/c4/main/catalog.json"

-- Computer Craft Code Catalog

local function addCacheBusterToURL(url)
    local cacheBuster = ("%x"):format(math.random(0, 2 ^ 30))
    local cacheBustedURL = url .. "?cb=" .. cacheBuster
    return cacheBustedURL
end

local function fetchContentAtURL(url)
    local request = http.get(addCacheBusterToURL(url))
    if (request == nil) then
        print('cannot fetch content at URL. Unable request ' .. url)
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
        print('cannot fetch catalog. Unable unserialize content')
        return nil
    end
    return catalog
end

local function getURLFromCatalog(name)
    local catalog = fetchCatalog()
    if catalog == nil then
        print('cannot URL from catalog. catalog is nil')
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
    local file = fs.open(name, "w")
    if file == nil then
        print('cannot load API from catalog. Unable to open file ' .. name)
        return nil
    end
    file.write(content)
    file.close()
    os.loadAPI(name)
end

function loadAPI(name)
    loadAPIFromCatalog(name)
end

name = args[1]
if name ~= nil then
    loadAPI(name)
end

args = {...}

CATALOG_URL = "https://raw.githubusercontent.com/brooswit/c4/main/catalog.json"

-- Computer Craft Code Catalog

local addCacheBusterToURL(url)
    local cacheBuster = ("%x"):format(math.random(0, 2 ^ 30))
    local cacheBustedURL = url .. "?cb=" .. cacheBuster
    return cacheBustedURL
end

local function fetchContentAtURL(url)
    local request = http.get(addCacheBusterToURL(url))
    if (request == nil) then
        return nil
    end
    local content = request.getAll()
    return content
end

local function fetchCatalog()
    local content = fetchContentAtURL(CATALOG_URL)
    if content ~= nil then
        local catalog = textutils.unserialize(content)
        return catalog
    else
        return nil
    end
end

local function getURLFromCatalog(name)
    local catalog = fetchCatalog()
    return catalog[name]
end

local function fetchContentFromCatalog(name)
    url = getURLFromCatalog(name)
    if url ~= nil then
        return fetchContentAtURL(url)
    else
        return nil
    end
end

local function loadAPIFromCatalog(name)
    local content = fetchContentFromCatalog(name)
    if content == nil then
        return nil
    end
    local file = fs.open(name, "w")
    if file == nil then
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

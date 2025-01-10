local http = game:GetService("HttpService")
local scriptUrl = "https://raw.githubusercontent.com/BebrikAU/Meta-lock/refs/heads/main/script.lua"

local function loadScriptFromUrl(url)
    local response = http:GetAsync(url)
    local scriptFunction, errorMessage = loadstring(response)
    if scriptFunction then
        scriptFunction()
    else
        error("Error loading script: " .. errorMessage)
    end
end

loadScriptFromUrl(scriptUrl)

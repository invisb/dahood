if not game:IsLoaded() then
	game.Loaded:Wait()
end

local success, response = pcall(request, {
    Url = "https://gamerant.com/roblox-da-hood-codes/",
    Method = "GET",
})

if success and response.StatusCode == 200 then
    local html = response.Body
    local codes = {}
    
    local activeSection = string.match(html, "All Active Da Hood Codes(.-)All Expired Da Hood Codes")
    if activeSection then
        for code in string.gmatch(activeSection, "<strong>(.-)</strong>") do
            if not code:find("%(NEW%)") then
                code = code:gsub("%s+", "")
                table.insert(codes, code)
            end
        end
        
        for _, code in ipairs(codes) do
            local args = {[1] = "EnterPromoCode",[2] = code}
            game:GetService("ReplicatedStorage"):WaitForChild("MainEvent"):FireServer(unpack(args))
            print(code)
            wait(5)
        end
    end
else
    warn("failed to get website (executor problem)")
end

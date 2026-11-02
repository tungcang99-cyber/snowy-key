-- ==========================================
-- Snowy Hub - Main Script with Key System
-- ==========================================

local SnowyHub = {}
SnowyHub.KEY_SYSTEM_URL = "https://raw.githubusercontent.com/tungcang99-cyber/snowy-key/refs/heads/main/keys.txt"

function SnowyHub:VerifyKeyOnline(inputKey)
    local success, response = pcall(function()
        return game:HttpGet(self.KEY_SYSTEM_URL)
    end)
    
    if not success then
        warn("[Snowy Hub] Failed to connect to key server!")
        return false
    end
    
    for line in response:gmatch("[^\r\n]+") do
        local key, expiryDate = line:match("^%s*(.-)%s*=%s*(.-)%s*$")
        if key and expiryDate then
            if key == inputKey then
                local year, month, day = expiryDate:match("(%d+)-(%d+)-(%d+)")
                local expiryTime = os.time({year = tonumber(year), month = tonumber(month), day = tonumber(day), hour = 23, min = 59, sec = 59})
                
                if os.time() <= expiryTime then
                    print("[Snowy Hub] Key Verified Successfully! Expires on: " .. expiryDate)
                    return true
                else
                    warn("[Snowy Hub] Key has expired on: " .. expiryDate)
                    return false
                end
            end
        end
    end
    
    warn("[Snowy Hub] Invalid Key provided!")
    return false
end

local playerKey = "Snowy2026"

if SnowyHub:VerifyKeyOnline(playerKey) then
    print("[Snowy Hub] ยินดีต้อนรับเข้าสู่ Snowy Hub!")
else
    print("[Snowy Hub] คีย์ไม่ถูกต้องหรือหมดอายุ")
end

return SnowyHub

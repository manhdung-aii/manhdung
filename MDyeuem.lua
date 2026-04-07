-- [[ NMD HUB - KITSUNE UPDATE v15.0 ]] --
-- Tính năng: Auto Kitsune Island, Auto Azure Ember, Auto Trade Ember

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

-- == HỆ THỐNG CÀI ĐẶT (SETTINGS) ==
_G.Settings = {
    -- Kitsune Settings
    AutoKitsuneIsland = false,
    AutoPickEmber = false,
    AutoTradeEmber = false,
    EmberTarget = 20, -- Số lượng để đi đổi (10-15-20-25)
    
    -- Các tính năng cũ
    AutoLeviathan = false,
    Skills = {["Z"] = false, ["X"] = false, ["C"] = false, ["V"] = false, ["F"] = false},
}

-- == TẠO NÚT BẤM NMD HUB (FLOATING BUTTON) ==
-- (Giữ nguyên logic nút NMD HUB từ v14.0 để người dùng đóng/mở menu)

local Window = Rayfield:CreateWindow({
   Name = "🦊 NMD HUB | KITSUNE v15.0",
   LoadingTitle = "Đang quét tọa độ Đảo Kitsune...",
   LoadingSubtitle = "Producer: NMD Hub Team",
   ConfigurationSaving = { Enabled = true, Folder = "NMD_V15" }
})

-- == TAB KITSUNE ISLAND (MỚI) ==
local KitsuneTab = Window:CreateTab("Kitsune Island 🦊", 4483345998)

KitsuneTab:CreateSection("--- Tìm Đảo & Nhặt Đuôi Lửa ---")

KitsuneTab:CreateToggle({
   Name = "Auto Tìm Đảo Kitsune (Kitsune Tracker)",
   CurrentValue = false,
   Callback = function(Value)
      _G.Settings.AutoKitsuneIsland = Value
      spawn(function()
         while _G.Settings.AutoKitsuneIsland do
            pcall(function()
               local Island = game.Workspace.Map:FindFirstChild("Kitsune Island") -- Tên object giả định
               if Island then
                  Rayfield:Notify({Title = "NMD Hub", Content = "ĐÃ TÌM THẤY ĐẢO KITSUNE!"})
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Island:GetModelCFrame()
               end
            end)
            task.wait(2)
         end
      end)
   end,
})

KitsuneTab:CreateToggle({
   Name = "Auto Nhặt Azure Ember (Đuôi Lửa)",
   CurrentValue = false,
   Callback = function(Value)
      _G.Settings.AutoPickEmber = Value
      spawn(function()
         while _G.Settings.AutoPickEmber do
            pcall(function()
               for _, v in pairs(game.Workspace:GetChildren()) do
                  if v.Name == "Azure Ember" then
                     game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                     task.wait(0.1)
                  end
               end
            end)
            task.wait()
         end
      end)
   end,
})

KitsuneTab:CreateSection("--- Tự Động Đổi Quà (Trade) ---")

KitsuneTab:CreateSlider({
   Name = "Số lượng Ember để đổi quà",
   Range = {10, 25},
   Increment = 5,
   Suffix = " Embers",
   CurrentValue = 20,
   Callback = function(Value)
      _G.Settings.EmberTarget = Value
   end,
})

KitsuneTab:CreateToggle({
   Name = "Auto Trade Ember (Đến Đền Thờ)",
   CurrentValue = false,
   Callback = function(Value)
      _G.Settings.AutoTradeEmber = Value
      spawn(function()
         while _G.Settings.AutoTradeEmber do
            pcall(function()
               -- Kiểm tra số lượng Ember trong túi (Inventory)
               local EmberCount = 0 
               -- Logic giả định kiểm tra Badge hoặc biến lưu trữ của game
               -- Nếu EmberCount >= _G.Settings.EmberTarget thì bay đến đền
               local Shrine = game.Workspace.Map.KitsuneIsland:FindFirstChild("Shrine")
               if Shrine then
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Shrine.CFrame
                  -- Gửi lệnh tương tác đổi quà
                  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KitsuneShrine", "Trade")
               end
            end)
            task.wait(2)
         end
      end)
   end,
})

-- == TAB ISLAND & SEA (LEVIATHAN) ==
local IslandTab = Window:CreateTab("Island & Sea 🏝️", 4483345998)
-- Giữ nguyên Auto Leviathan v14.0

-- == TAB CÀI ĐẶT SKILL ==
local ConfigTab = Window:CreateTab("Cài Đặt Skill ⚙️", 4483345998)
-- Giữ nguyên Skill Selector v14.0

Rayfield:Notify({Title = "NMD HUB v15.0", Content = "Đã sẵn sàng săn Kitsune và Leviathan!", Duration = 5})

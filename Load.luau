local Player = game:GetService("Players").LocalPlayer

function LoadHierarchy()
    local function buildHierarchy(instance)
        local instanceTable = {}
        instanceTable.Type = instance.ClassName

        for _, child in ipairs(instance:GetChildren()) do
            instanceTable[child.Name] = buildHierarchy(child)
        end

        return instanceTable
    end

    local gameHierarchy = buildHierarchy(game.ReplicatedStorage)

    -- Function to print the hierarchy visually with indentation
    local function printHierarchy(tbl, indentLevel)
        indentLevel = indentLevel or 0
        local indent = string.rep("- ", indentLevel)

        for key, value in pairs(tbl) do
            if key == "Type" then
                -- Skip printing Type as a separate line, it's used within the parent's line
            else
                local instanceType = value.Type or "Unknown"
                print(indent .. key .. " (" .. instanceType .. ")")
                printHierarchy(value, indentLevel + 1)
            end
        end
    end

    print("--- Game Hierarchy ---")
    printHierarchy(gameHierarchy)
    print("----------------------")

    return gameHierarchy
end

function SetupUi(hier)
    local Gui = Instance.new("ScreenGui", Player.PlayerGui)
    Gui.Name = "SigmaUi"
    local Frame = Instance.new("ScrollingFrame", Gui)
    Frame.Name = "BG"
    Frame.Size = UDim2.fromScale(0.35, 0.8)
    Frame.Position = UDim2.fromScale(0.6, 0.1)
    Frame.BackgroundColor3 = Color3.new(0.7, 0.7, 0.7)

    local lay = Instance.new("UIListLayout", Frame)
    lay.SortOrder = Enum.SortOrder.LayoutOrder
    lay.HorizontalFlex = Enum.UIFlexAlignment.Fill
    
    for k, v in pairs(hier) do
        local btn = Instance.new("TextButton", Frame)
        btn.Text = k
        btn.TextScaled = true
    end
end

function Ret()
    local h = LoadHierarchy()
    SetupUi(h)
end



Ret()

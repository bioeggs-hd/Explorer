function LoadHierarchy()
    local function buildHierarchy(instance)
        local instanceTable = {}
        instanceTable.Type = instance.ClassName

        for _, child in ipairs(instance:GetChildren()) do
            instanceTable[child.Name] = buildHierarchy(child)
        end

        return instanceTable
    end

    local gameHierarchy = buildHierarchy(game)

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

-- To run the function and see the output:
-- local hierarchyTable = LoadHierarchy()
-- print(hierarchyTable) -- This will print the table address, not its contents.
-- The printHierarchy function inside LoadHierarchy already handles the visual output.

return LoadHierarchy()

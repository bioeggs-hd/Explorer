--!strict

-- Define a function to recursively traverse and print the instance hierarchy.
-- @param instance The current instance to process.
-- @param indentLevel The current indentation level (determines the number of dashes).
-- @param outputTable A table to store the lines of the hierarchy.
local function mapInstanceHierarchy(instance: Instance, indentLevel: number, outputTable: {string})
    -- Create the indentation string based on the indentLevel.
    -- Each level adds a dash and a space.
    local indent = string.rep("- ", indentLevel)

    -- Format the instance's information: name (Type).
    -- If the instance is the 'game' object, just show its name.
    local instanceInfo = ""
    if instance == game then
        instanceInfo = instance.Name
    else
        instanceInfo = string.format("%s (%s)", instance.Name, instance.ClassName)
    end

    -- Add the formatted line to the output table.
    table.insert(outputTable, indent .. instanceInfo)

    -- Iterate through all children of the current instance.
    -- The children are sorted alphabetically by name for consistent output.
    local children = instance:GetChildren()
    table.sort(children, function(a, b)
        return a.Name < b.Name
    end)

    for _, child in ipairs(children) do
        -- Recursively call the function for each child, incrementing the indent level.
        mapInstanceHierarchy(child, indentLevel + 1, outputTable)
    end
end

-- Main part of the script:
-- 1. Create an empty table to hold all the lines of the hierarchy.
local hierarchyLines: {string} = {}

-- 2. Start the mapping process from the 'game' object with an initial indent level of 0.
mapInstanceHierarchy(game, 0, hierarchyLines)

-- 3. Join all the lines in the table into a single string, separated by newlines.
local fullHierarchyString = table.concat(hierarchyLines, "\n")

-- 4. Print the resulting hierarchy string to the output.
-- In Roblox Studio, this will appear in the Output window.
print("--- Game Instance Hierarchy ---")
print(fullHierarchyString)
print("-----------------------------")

-- You can also return this string if you want to use it in a UI element or another script.
return fullHierarchyString

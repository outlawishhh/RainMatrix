-- variables
local numColumns = 40  -- columns (should match MatrixColumns in the skin)
local maxChars = 30    -- max characters per column
local charRefreshRate = 2  -- how often (in updates) to refresh characters
local dropSpeed = {}    -- speed of each column's drops
local columns = {}      -- matrix of characters
local positions = {}    -- current positions of drops
local lengths = {}      -- length of each column's drops
local brightChars = {}  -- position of bright (lead) character in each column

-- binary characters to use (1s and 0s only)
local binaryChars = {"0", "1"}

-- probability weights for 1s and 0s (higher value = more common)
local charWeights = {
    ["0"] = 40,  
    ["1"] = 60   
}

function Initialize()
    numColumns = tonumber(SKIN:GetVariable('MatrixColumns'))
    for i = 1, numColumns do
        local meterName = "MatrixColumn" .. i
        SKIN:Bang('!SetOption', meterName, 'MeterStyle', 'MatrixColumnStyle')
        SKIN:Bang('!SetOption', meterName, 'X', tostring((i-1) * (SKIN:GetVariable('MatrixWidth') / numColumns)))
        SKIN:Bang('!SetOption', meterName, 'Y', '0')
        SKIN:Bang('!SetOption', meterName, 'StringAlign', 'Left')
        SKIN:Bang('!SetOption', meterName, 'Text', '')
        
        columns[i] = {}
        for j = 1, maxChars do
            columns[i][j] = getWeightedRandomChar()
        end
        
        dropSpeed[i] = math.random(1, 4)
        positions[i] = -math.random(1, maxChars)
        lengths[i] = math.random(5, maxChars)
        brightChars[i] = 1 
    end
    
    SKIN:Bang('!UpdateMeter', '*')
    SKIN:Bang('!Redraw')
end

function getWeightedRandomChar()
    local totalWeight = 0
    for _, weight in pairs(charWeights) do
        totalWeight = totalWeight + weight
    end
    
    local randomValue = math.random(1, totalWeight)
    local currentWeight = 0
    
    for char, weight in pairs(charWeights) do
        currentWeight = currentWeight + weight
        if randomValue <= currentWeight then
            return char
        end
    end
    
    return "1"
end

function Update()
    local updateCount = SKIN:GetVariable('UpdateCount', '0')
    updateCount = tonumber(updateCount) or 0
    SKIN:Bang('!SetVariable', 'UpdateCount', tostring(updateCount + 1))
    
    if updateCount % charRefreshRate == 0 then
        for i = 1, numColumns do
            local refreshCount = math.random(1, 3)  
            for _ = 1, refreshCount do
                local idx = math.random(1, maxChars)
                columns[i][idx] = getWeightedRandomChar()
            end
        end
    end
    
    for i = 1, numColumns do
  
        if updateCount % dropSpeed[i] == 0 then
            positions[i] = positions[i] + 1

            if positions[i] > maxChars + lengths[i] then
                positions[i] = -math.random(5, 15)
                lengths[i] = math.random(5, maxChars)
                dropSpeed[i] = math.random(1, 4)
            end
            
            brightChars[i] = positions[i]
        end
        
        local columnText = ''
        for j = 1, maxChars do
            local visiblePos = j - positions[i]
            
            if visiblePos > 0 and visiblePos <= lengths[i] then
                local char = columns[i][j % maxChars + 1]
                
                if j == brightChars[i] then
                    columnText = columnText .. '[#CharColor]' .. char
                else
                    local fadeAmount = math.max(0, 1 - (visiblePos / lengths[i]))
                    local fadeFactor = math.floor(fadeAmount * 4) + 1  
                    columnText = columnText .. '[#FadeColor' .. fadeFactor .. ']' .. char
                end
            else
                columnText = columnText .. ' '
            end
            
            if j < maxChars then
                columnText = columnText .. '\r\n'
            end
        end
        
        SKIN:Bang('!SetOption', 'MatrixColumn' .. i, 'Text', columnText)
    end
    SKIN:Bang('!UpdateMeter', '*')
    SKIN:Bang('!Redraw')
    
    return 0 
end
